import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/feature/chat_bot/presentation/manager/chat_bot_cubit.dart';
import 'package:raai/feature/chat_bot/presentation/view/widget/custom_bubble_chat.dart';
import 'package:raai/feature/chat_bot/presentation/view/widget/custom_bubble_loading.dart';
import 'package:raai/feature/chat_bot/presentation/view/widget/custom_bubble_user.dart';
import 'package:raai/feature/chat_bot/presentation/view/widget/custom_upper_chat_bot_view.dart';
import 'package:raai/feature/profile/presentation/manager/profile/profile_cubit.dart';

class ChatBotViewBody extends StatefulWidget {
  const ChatBotViewBody({super.key});

  @override
  State<ChatBotViewBody> createState() => _ChatBotViewBodyState();
}

class _ChatBotViewBodyState extends State<ChatBotViewBody> {
  late final ScrollController scrollController;
  bool showScrollToBottom = false;
  int lastMessageCount = 0;
  bool wasKeyboardOpen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      final isNearBottom =
          scrollController.position.maxScrollExtent -
              scrollController.position.pixels <
          150;

      if (isNearBottom && showScrollToBottom) {
        setState(() => showScrollToBottom = false);
      } else if (!isNearBottom && !showScrollToBottom) {
        setState(() => showScrollToBottom = true);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    if (!scrollController.hasClients) return;

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChatBotCubit>();
    final controller = context.read<ChatBotCubit>();
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    if (state.messages.length != lastMessageCount ||
        (keyboardOpen && !wasKeyboardOpen)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToBottom();
      });
      lastMessageCount = state.messages.length;
    }
    wasKeyboardOpen = keyboardOpen;

    return Stack(
      children: [
        RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const RSizedBox(height: 55),
              const CustomUpperChatBotView(),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    if (state.messages[index].role == 'user') {
                      return CustomBubbleUser(
                        message: state.messages[index].message,
                      );
                    } else if (state.messages[index].isLoading) {
                      return const CustomBubbleLoading();
                    } else if (state.messages[index].isError) {
                      return CustomBubbleChat(
                        message: state.messages[index].message,
                        isError: true,
                        onTap: () {
                          final user = context
                              .read<ProfileCubit>()
                              .profileUserEntity;
                          controller.retryLastMessage(
                            sessionId: user!.personalData.id.toString(),
                            userName: user.personalData.firstName,
                            userGender: user.personalData.gender,
                          );
                        },
                      );
                    } else {
                      return CustomBubbleChat(
                        message: state.messages[index].message,
                      );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return const RSizedBox(height: 24);
                  },
                  itemCount: state.messages.length,
                ),
              ),
              // const RSizedBox(height: 90),
            ],
          ),
        ),
        if (showScrollToBottom)
          Positioned(
            left: 16,
            bottom: 100,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: showScrollToBottom ? 1 : 0,
              child: FloatingActionButton(
                mini: true,
                shape: const OvalBorder(),
                backgroundColor: AppColor.white,
                foregroundColor: AppColor.black,
                elevation: 5,
                splashColor: AppColor.primaryLightHover,
                onPressed: scrollToBottom,
                child: const Icon(CupertinoIcons.arrow_down),
              ),
            ),
          ),
      ],
    );
  }
}
