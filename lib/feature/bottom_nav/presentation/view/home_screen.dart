import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/feature/bottom_nav/presentation/manager/bottom_nav_cubit.dart';
import 'package:raai/feature/bottom_nav/presentation/manager/voice_ass_cubit/voice_ass_cubit.dart';
import 'package:raai/feature/bottom_nav/presentation/manager/voice_cubit/voice_cubit.dart';
import 'package:raai/feature/bottom_nav/presentation/view/widget/custom_bottom_nav_bar.dart';
import 'package:raai/feature/bottom_nav/presentation/view/widget/custom_chat_bot_sender.dart';
import 'package:raai/feature/chat_bot/presentation/view/chat_bot_view.dart';
import 'package:raai/feature/home/presentation/view/home_view.dart';
import 'package:raai/feature/medication/presenation/view/medication_view.dart';
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
          const HomeView(),
          state.isSelected[1] ? const MedicationView() : const SizedBox(),
          state.isSelected[2] ? const ChatBotView() : const SizedBox(),
          state.isSelected[3] ? const ReadsView() : const SizedBox(),
          const ProfileView(),
          //state.isSelected[4] ? const ProfileView() : const SizedBox(),
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: !controller.isChat,
        replacement: const CustomChatBotSender(),
        child: CustomBottomNavBar(controller: controller, state: state),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<VoiceCubit, VoiceState>(
            builder: (context, state) {
              final cubit = context.read<VoiceCubit>();

              return FloatingActionButton(
                elevation: 0,
                heroTag: null,
                backgroundColor: state == VoiceState.listening
                    ? AppColor.primaryNormal
                    : AppColor.white.withAlpha(100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(180),
                ),
                onPressed: () {
                  if (state == VoiceState.idle) {
                    openVoice(context);
                  } else if (state == VoiceState.listening) {
                    cubit.stopListening();
                  }
                },
                child: Icon(
                  state == VoiceState.listening ? Icons.mic : Icons.mic_none,
                ),
              );
            },
          ),
          if (controller.currentIndex == 1)
            Padding(
              padding: REdgeInsets.only(top: 8),
              child: FloatingActionButton(
                onPressed: () {
                  context.push(AppRoutes.addMedication);
                },
                heroTag: 'add-medication',
                backgroundColor: AppColor.primaryNormal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(180),
                ),
                splashColor: AppColor.primaryNormalHover,
                child: Icon(
                  CupertinoIcons.plus,
                  color: AppColor.white,
                  size: 21.r,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void openVoice(BuildContext context) {
    final cubit = context.read<VoiceCubit>();
    cubit.startListening();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => MultiBlocProvider(
        providers: [BlocProvider(create: (context) => VoiceAssCubit())],
        child: BlocProvider.value(
          value: cubit,
          child: const VoiceBottomSheet(),
        ),
      ),
    ).whenComplete(() {
      cubit.stopListening();
    });
  }
}

class VoiceBottomSheet extends StatelessWidget {
  const VoiceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VoiceCubit>();

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'اتكلم دلوقتي 🎤',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: StreamBuilder<String>(
                  stream: cubit.textStream,
                  builder: (context, snapshot) {
                    final text = snapshot.data ?? '';

                    return Text(
                      text.isEmpty ? '🎤 جاري الاستماع...' : text,
                      style: const TextStyle(fontSize: 16),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: AppButton.outline(
                    onPressed: () {
                      cubit.resetText();
                      cubit.startListening();
                    },
                    text: 'إعادة',
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: StreamBuilder<String>(
                    stream: cubit.textStream,
                    builder: (context, snapshot) {
                      final text = snapshot.data ?? '';

                      return AppButton.filled(
                        onPressed: text.isEmpty
                            ? null
                            : () {
                                cubit.stopListening();
                                log(text.toString());
                                context.read<VoiceAssCubit>().getPredictVoice(
                                  text,
                                );
                              },
                        text: 'تأكيد',
                      );
                    },
                  ),
                ),
                BlocListener<VoiceAssCubit, VoiceAssState>(
                  listener: (context, state) {
                    if (state is VoiceAssLoading) {
                      AppConstant.showLoadingDialog(context);
                    }
                    if (state is VoiceAssSuccess) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                    if (state is VoiceAssFailure) {
                      Navigator.pop(context);
                    }
                  },
                  child: const SizedBox.shrink(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
