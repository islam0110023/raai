import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raai/feature/bottom_nav/presentation/manager/bottom_nav_cubit.dart';
import 'package:raai/feature/bottom_nav/presentation/view/widget/coming_soon_body.dart';
import 'package:raai/feature/bottom_nav/presentation/view/widget/custom_bottom_nav_bar.dart';
import 'package:raai/feature/bottom_nav/presentation/view/widget/custom_chat_bot_sender.dart';
import 'package:raai/feature/chat_bot/presentation/view/chat_bot_view.dart';
import 'package:raai/feature/profile/presentation/view/profile_view.dart';
import 'package:raai/feature/reads/presentation/view/reads_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BottomNavCubit>();
    final state = context.watch<BottomNavCubit>();

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,

      body: IndexedStack(
        index: state.currentIndex,
        children: [
          const ComingSoonBody(isCaregiver: false),
          state.isSelected[1]
              ? const ComingSoonBody(isCaregiver: false)
              : const SizedBox(),
          state.isSelected[2] ? const ChatBotView() : const SizedBox(),
          state.isSelected[3] ? const ReadsView() : const SizedBox(),
          state.isSelected[4] ? const ProfileView() : const SizedBox(),
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: !controller.isChat,
        replacement: const CustomChatBotSender(),
        child: CustomBottomNavBar(controller: controller, state: state),
      ),
    );
  }
}
