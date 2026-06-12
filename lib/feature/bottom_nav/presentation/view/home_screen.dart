import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/add_reads/presentation/manager/add_read/add_reading_cubit.dart';
import 'package:raai/feature/bottom_nav/presentation/manager/bottom_nav_cubit.dart';
import 'package:raai/feature/bottom_nav/presentation/manager/voice_cubit/voice_cubit.dart';
import 'package:raai/feature/bottom_nav/presentation/view/widget/custom_bottom_nav_bar.dart';
import 'package:raai/feature/bottom_nav/presentation/view/widget/custom_buttom_sheet_voice.dart';
import 'package:raai/feature/bottom_nav/presentation/view/widget/custom_chat_bot_sender.dart';
import 'package:raai/feature/chat_bot/presentation/view/chat_bot_view.dart';
import 'package:raai/feature/home/presentation/view/home_view.dart';
import 'package:raai/feature/medication/presenation/view/medication_view.dart';
import 'package:raai/feature/profile/presentation/view/profile_view.dart';
import 'package:raai/feature/reads/presentation/view/reads_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<int, bool> _loadedPages = {0: true};

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<VoiceAssistantCubit>().initSpeech();
    });
  }

  void _trackPageSelection(int index) {
    if (!_loadedPages.containsKey(index)) {
      setState(() {
        _loadedPages[index] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavCubit = context.watch<BottomNavCubit>();
    final controller = context.read<BottomNavCubit>();

    _trackPageSelection(bottomNavCubit.currentIndex);

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: IndexedStack(
        index: bottomNavCubit.currentIndex,
        children: [
          const HomeView(),
          _loadedPages.containsKey(1)
              ? const MedicationView()
              : const SizedBox.shrink(),
          _loadedPages.containsKey(2)
              ? const ChatBotView()
              : const SizedBox.shrink(),
          _loadedPages.containsKey(3)
              ? const ReadsView()
              : const SizedBox.shrink(),
          const ProfileView(),
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: !bottomNavCubit.isChat,
        replacement: const CustomChatBotSender(),
        child: CustomBottomNavBar(
          controller: controller,
          state: bottomNavCubit,
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocConsumer<VoiceAssistantCubit, VoiceAssistantState>(
            listener: (context, state) {
              if (state is VoiceAssistantError && state.isPermissionError) {
                showAnimatedTopSnackBar(
                  context,
                  message: 'حصل مشكلة',
                  subMessage: state.message,
                  isError: true,
                );
              }
            },
            builder: (context, voiceState) {
              final isListening = voiceState is VoiceAssistantListening;
              final isInitializing = voiceState is VoiceAssistantInitializing;

              return FloatingActionButton(
                elevation: 0,
                heroTag: 'voice-assistant-btn',
                backgroundColor: isListening
                    ? Colors.redAccent
                    : AppColor.primaryNormal,
                shape: const CircleBorder(),
                onPressed: () {
                  if (isListening) {
                    context.read<VoiceAssistantCubit>().stopListeningOnly();
                  } else {
                    openVoice(context);
                  }
                },
                child: isInitializing
                    ? const CupertinoActivityIndicator(color: Colors.white)
                    : Icon(
                        isListening ? Icons.stop : Icons.mic,
                        color: Colors.white,
                      ),
              );
            },
          ),
          if (bottomNavCubit.currentIndex == 1) ...[
            SizedBox(height: 8.h),
            FloatingActionButton(
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
          ],
        ],
      ),
    );
  }

  void openVoice(BuildContext context) {
    context.read<VoiceAssistantCubit>().startListening();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0D0E12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (modalContext) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<VoiceAssistantCubit>()),
            BlocProvider(
              create: (modalContext) => AddReadingCubit(getIt(), getIt()),
            ),
          ],
          child: MultiBlocListener(
            listeners: [
              BlocListener<VoiceAssistantCubit, VoiceAssistantState>(
                listenWhen: (previous, current) =>
                    current is VoiceAssistantInitialized ||
                    current is VoiceAssistantSuccess,
                listener: (context1, state) {
                  if (state is VoiceAssistantSuccess) {
                    showAnimatedTopSnackBar(
                      context,
                      message: 'نجحت',
                      subMessage: 'تم التحليل بنجاح',
                    );
                    if (state.responseData.function == 'nav_home') {
                      context.read<BottomNavCubit>().changeIndex(0);
                    } else if (state.responseData.function ==
                        'need_clarification') {
                      showAnimatedTopSnackBar(
                        context,
                        message: 'سوال مش مفهوم',
                        subMessage: state.responseData.message!,
                        isError: true,
                      );
                      context.read<VoiceAssistantCubit>().startListening();
                      return;
                    } else if (state.responseData.function ==
                        'need_classification') {
                      showAnimatedTopSnackBar(
                        context,
                        message: 'سوال مش مفهوم',
                        subMessage:
                            'طلبك مش مفهوم ممكن توضح اكتر علشان نقدر نساعدك',
                        isError: true,
                      );
                      context.read<VoiceAssistantCubit>().startListening();
                      return;
                    } else if (state.responseData.function ==
                        'nav_models_monthly') {
                      context.push(AppRoutes.sugarMonthlyModel);
                    } else if (state.responseData.function ==
                        'nav_models_generic') {
                      context.push(AppRoutes.selectModels);
                    } else if (state.responseData.function ==
                        'nav_measurements_log_glucose') {
                      context.read<BottomNavCubit>().changeIndex(3);
                    } else if (state.responseData.function ==
                        'nav_measurements_log_pressure') {
                      context.read<BottomNavCubit>().changeIndex(3);
                    } else if (state.responseData.function ==
                        'nav_measurements_log_generic') {
                      context.read<BottomNavCubit>().changeIndex(3);
                    } else if (state.responseData.function ==
                        'nav_add_measurement_glucose') {
                      context.push(AppRoutes.addReads, extra: true);
                    } else if (state.responseData.function ==
                        'nav_add_measurement_pressure') {
                      context.push(AppRoutes.addReads, extra: false);
                    } else if (state.responseData.function ==
                        'nav_add_measurement_generic') {
                      context.push(AppRoutes.addReads, extra: true);
                    } else if (state.responseData.function == 'nav_profile') {
                      context.read<BottomNavCubit>().changeIndex(4);
                    } else if (state.responseData.function == 'nav_chatbot') {
                      context.read<BottomNavCubit>().changeIndex(2);
                    } else if (state.responseData.function ==
                        'nav_medications') {
                      context.read<BottomNavCubit>().changeIndex(1);
                    } else if (state.responseData.function ==
                            'log_measurement' &&
                        state.responseData.kind == 'pressure') {
                      if (state.responseData.error == 'invalid') {
                        showAnimatedTopSnackBar(
                          context,
                          message: 'بيانات غلط',
                          subMessage: state.responseData.messageArgs!,
                          isError: true,
                        );
                        context.read<VoiceAssistantCubit>().startListening();
                        return;
                      } else {
                        final cubit = context1.read<AddReadingCubit>();
                        cubit.systolicController.text = state.responseData.sys
                            .toString();
                        cubit.diastolicController.text = state.responseData.dia
                            .toString();
                        cubit.addBlood();
                        return;
                      }
                    } else if (state.responseData.function ==
                            'log_measurement' &&
                        state.responseData.kind == 'glucose') {
                      if (state.responseData.error == 'invalid') {
                        showAnimatedTopSnackBar(
                          context,
                          message: 'بيانات غلط',
                          subMessage: state.responseData.messageArgs!,
                          isError: true,
                        );
                        context.read<VoiceAssistantCubit>().startListening();
                        return;
                      } else {
                        final cubit = context1.read<AddReadingCubit>();
                        cubit.sugarController.text = state
                            .responseData
                            .valueMgdl
                            .toString();
                        cubit.addSugar();
                        return;
                      }
                    } else if (state.responseData.function ==
                        'get_next_med_time') {
                      context.read<BottomNavCubit>().changeIndex(0);
                    } else if (state.responseData.function ==
                        'trigger_danger_alert') {
                    }
                    // else if (state.responseData.function ==
                    //     'get_last_glucose') {
                    // } else if (state.responseData.function ==
                    //     'get_last_blood_pressure') {
                    // }
                    else if (state.responseData.function == 'check_health') {
                    } else if (state.responseData.function == 'add_caregiver') {
                      context.push(AppRoutes.addCaregiver);
                    } else if (state.responseData.function ==
                        'call_caregiver') {}

                    if (Navigator.canPop(context)) Navigator.pop(context);
                  } else {
                    if (Navigator.canPop(context)) Navigator.pop(context);
                  }
                },
              ),
              BlocListener<AddReadingCubit, AddReadingState>(
                listener: (context, state) {
                  if (state is AddReadingSugarSuccess) {
                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                    showAnimatedTopSnackBar(
                      context,
                      message: 'نجحت',
                      subMessage: 'تم تسجيل قيمة السكر بنجاح',
                    );
                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                  }
                  if (state is AddReadingSugarFailure) {
                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                    showAnimatedTopSnackBar(
                      context,
                      isError: true,
                      message: 'في مشكلة',
                      subMessage: state.message,
                    );
                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                  }
                  if (state is AddReadingSugarIsEmpty) {
                    showAnimatedTopSnackBar(
                      context,
                      isError: true,
                      message: 'في مشكلة',
                      subMessage: 'ادخل قيمة السكر',
                    );
                  }
                  if (state is AddReadingSugarLoading) {
                    AppConstant.showLoadingDialog(context);
                  }
                  if (state is AddReadingBloodSuccess) {
                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                    showAnimatedTopSnackBar(
                      context,
                      message: 'نجحت',
                      subMessage: 'تم تسجيل قيم الضغط بنجاح',
                    );
                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                  }
                  if (state is AddReadingBloodFailure) {
                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                    showAnimatedTopSnackBar(
                      context,
                      isError: true,
                      message: 'في مشكلة',
                      subMessage: state.message,
                    );
                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                  }
                  if (state is AddReadingBloodIsEmpty) {
                    showAnimatedTopSnackBar(
                      context,
                      isError: true,
                      message: 'في مشكلة',
                      subMessage: 'ادخل قيم الضغط',
                    );
                  }
                  if (state is AddReadingBloodLoading) {
                    AppConstant.showLoadingDialog(context);
                  }
                },
              ),
            ],
            child: const CustomBottomSheetVoice(),
          ),
        );
      },
    ).then((_) {
      if (!context.mounted) return;
      if (context.read<VoiceAssistantCubit>().state
          is VoiceAssistantListening) {
        context.read<VoiceAssistantCubit>().stopListeningOnly();
      }
    });
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:raai/core/utils/app_color.dart';
// import 'package:raai/core/utils/routes.dart';
// import 'package:raai/core/utils/styling.dart';
// import 'package:raai/feature/bottom_nav/presentation/manager/bottom_nav_cubit.dart';
// import 'package:raai/feature/bottom_nav/presentation/manager/voice_cubit/voice_cubit.dart';
// import 'package:raai/feature/bottom_nav/presentation/view/widget/custom_bottom_nav_bar.dart';
// import 'package:raai/feature/bottom_nav/presentation/view/widget/custom_chat_bot_sender.dart';
// import 'package:raai/feature/chat_bot/presentation/view/chat_bot_view.dart';
// import 'package:raai/feature/home/presentation/view/home_view.dart';
// import 'package:raai/feature/medication/presenation/view/medication_view.dart';
// import 'package:raai/feature/profile/presentation/view/profile_view.dart';
// import 'package:raai/feature/reads/presentation/view/reads_view.dart';
// import 'dart:math' as math;
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = context.read<BottomNavCubit>();
//     final state = context.watch<BottomNavCubit>();
//
//     return Scaffold(
//       extendBody: true,
//       resizeToAvoidBottomInset: true,
//
//       body: IndexedStack(
//         index: state.currentIndex,
//         children: [
//           const HomeView(),
//           state.isSelected[1] ? const MedicationView() : const SizedBox(),
//           state.isSelected[2] ? const ChatBotView() : const SizedBox(),
//           state.isSelected[3] ? const ReadsView() : const SizedBox(),
//           const ProfileView(),
//           //state.isSelected[4] ? const ProfileView() : const SizedBox(),
//         ],
//       ),
//       bottomNavigationBar: Visibility(
//         visible: !controller.isChat,
//         replacement: const CustomChatBotSender(),
//         child: CustomBottomNavBar(controller: controller, state: state),
//       ),
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           BlocBuilder<VoiceAssistantCubit, VoiceAssistantState>(
//             builder: (context, state) {
//               return FloatingActionButton(
//                 elevation: 0,
//                 heroTag: 'voice-assistant-btn',
//                 backgroundColor: AppColor.primaryNormal,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(180),
//                 ),
//                 onPressed: () {
//                   // لو مش شغال، انده على الميثود اللي كتبناها فوق عشان تفتح الكرة التفاعلية
//                   openVoice(context);
//                 },
//                 child: const Icon(Icons.mic, color: Colors.white),
//               );
//             },
//           ),
//           if (controller.currentIndex == 1)
//             Padding(
//               padding: REdgeInsets.only(top: 8),
//               child: FloatingActionButton(
//                 onPressed: () {
//                   context.push(AppRoutes.addMedication);
//                 },
//                 heroTag: 'add-medication',
//                 backgroundColor: AppColor.primaryNormal,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadiusGeometry.circular(180),
//                 ),
//                 splashColor: AppColor.primaryNormalHover,
//                 child: Icon(
//                   CupertinoIcons.plus,
//                   color: AppColor.white,
//                   size: 21.r,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   void openVoice(BuildContext context) {
//     // 1. ابدأ عملية الاستماع أول ما تفتح الواجهة
//     context.read<VoiceAssistantCubit>().startListening();
//
//     // 2. اظهر الـ Bottom Sheet اللي فيها الكرة التفاعلية
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: const Color(
//         0xFF0D0E12,
//       ), // خلفية داكنة ممتازة لألوان الـ Gemini النيون
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
//       ),
//       builder: (modalContext) {
//         // بنستخدم BlocProvider.value عشان نمرر نفس الـ Cubit الحالي للـ BottomSheet
//         return BlocProvider.value(
//           value: context.read<VoiceAssistantCubit>(),
//           child: BlocBuilder<VoiceAssistantCubit, VoiceAssistantState>(
//             builder: (context, state) {
//               // لو المستخدم قفل الاستماع أو حصل خطأ، نقفل الـ BottomSheet تلقائياً
//               if (state is VoiceAssistantInitial ||
//                   state is VoiceAssistantError) {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   if (Navigator.canPop(context)) Navigator.pop(context);
//                 });
//               }
//
//               // جلب قيمة الـ amplitude الحالية من الـ state
//               double currentAmplitude = 0.0;
//               String textOutput = 'جاري الاستماع...';
//
//               if (state is VoiceAssistantListening) {
//                 currentAmplitude = state.amplitude;
//                 textOutput = state.recognizedText;
//               }
//
//               return Padding(
//                 padding: EdgeInsets.only(
//                   bottom: MediaQuery.of(context).viewInsets.bottom,
//                 ),
//                 child: Container(
//                   padding: const EdgeInsets.all(24),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // شريط سحب علوي للشكل الجمالي
//                       Container(
//                         width: 40.w,
//                         height: 4.h,
//                         decoration: BoxDecoration(
//                           color: Colors.white24,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       SizedBox(height: 30.h),
//
//                       // نص الـ Speech to Text اللي بيظهر كلام المستخدم لايف
//                       Text(
//                         textOutput,
//                         textAlign: TextAlign.center,
//                         style: AppTextStyles.s12.w500.white,
//                       ),
//                       SizedBox(height: 40.h),
//
//                       // هنا بنستدعي الكرة اللي أنت ضايفها في الكود وتحقن فيها الـ Amplitude الحالية
//                       Center(
//                         child: GeminiSphereWidget(amplitude: currentAmplitude),
//                       ),
//                       SizedBox(height: 40.h),
//
//                       // زرار الإغلاق أو إلغاء الأمر الصوتي
//                       IconButton(
//                         onPressed: () {
//                           context.read<VoiceAssistantCubit>().stopListening();
//                           Navigator.pop(context);
//                         },
//                         icon: const Icon(
//                           Icons.close_rounded,
//                           color: Colors.white54,
//                           size: 28,
//                         ),
//                       ),
//                       SizedBox(height: 10.h),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     ).then((_) {
//       // التأكيد على إيقاف المايك لو المستخدم سحب الـ BottomSheet لتحت وقفلها بنفسه
//       if (!context.mounted) return;
//       context.read<VoiceAssistantCubit>().stopListening();
//     });
//   }
// }
//
// class GeminiSphereWidget extends StatefulWidget {
//   const GeminiSphereWidget({super.key, required this.amplitude});
//   final double amplitude;
//
//   @override
//   State<GeminiSphereWidget> createState() => _GeminiSphereWidgetState();
// }
//
// class _GeminiSphereWidgetState extends State<GeminiSphereWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     // Continuous loop for ambient organic motion
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 4),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return CustomPaint(
//           size: const Size(280, 280),
//           painter: GeminiSpherePainter(
//             animationValue: _controller.value,
//             amplitude: widget.amplitude,
//           ),
//         );
//       },
//     );
//   }
// }
//
// class GeminiSpherePainter extends CustomPainter {
//   GeminiSpherePainter({required this.animationValue, required this.amplitude});
//   final double animationValue;
//   final double amplitude;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final baseRadius =
//         (size.width / 3.2) + (amplitude * 35); // Base scale react to voice
//
//     // 1. Draw Outer Glow Layer
//     final glowPaint = Paint()
//       ..style = PaintingStyle.fill
//       ..maskFilter =
//           const MaskFilter.blur(BlurStyle.normal, 40) // Diffused neon aura
//       ..shader = RadialGradient(
//         colors: [
//           const Color(0xFF9B51E0).withAlpha(140), // Glowing Purple
//           const Color(0xFF2F80ED).withAlpha(100), // Cyber Blue
//           Colors.transparent,
//         ],
//       ).createShader(Rect.fromCircle(center: center, radius: baseRadius * 1.8));
//
//     canvas.drawCircle(center, baseRadius * 1.5, glowPaint);
//
//     // 2. Draw the Fluid Liquid Layers
//     // We combine multiple layers moving at different phases to get the liquid organic overlap
//     _drawLiquidBlob(canvas, center, baseRadius, 8, 0.0, [
//       const Color(0xFF4285F4), // Gemini Blue
//       const Color(0xFF9B51E0), // Deep Violet
//     ]);
//
//     _drawLiquidBlob(canvas, center, baseRadius * 0.95, 6, math.pi / 2, [
//       const Color(0xFFEC407A), // Hot Pink
//       const Color(0xFF2F80ED), // Cyan Blue
//     ]);
//
//     _drawLiquidBlob(canvas, center, baseRadius * 0.90, 5, math.pi, [
//       const Color(0x808000FF), // Translucent Purple overlay
//       const Color(0x994285F4),
//     ]);
//   }
//
//   void _drawLiquidBlob(
//     Canvas canvas,
//     Offset center,
//     double radius,
//     int waveCount,
//     double phaseShift,
//     List<Color> colors,
//   ) {
//     final Path path = Path();
//     final double angleStep =
//         (math.pi * 2) / 200; // 200 resolution points for smooth curves
//
//     final paint = Paint()
//       ..style = PaintingStyle.fill
//       ..shader = LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: colors,
//       ).createShader(Rect.fromCircle(center: center, radius: radius));
//
//     for (int i = 0; i <= 200; i++) {
//       final double angle = i * angleStep;
//
//       // Calculate dynamic wave modulation using a combination of sine frequencies
//       // Modulates dynamic intensity when amplitude peaks
//       final double waveModulation =
//           math.sin(
//             angle * waveCount + (animationValue * math.pi * 2) + phaseShift,
//           ) *
//           (8.0 + (amplitude * 25.0));
//
//       final double currentRadius = radius + waveModulation;
//
//       final double x = center.dx + math.cos(angle) * currentRadius;
//       final double y = center.dy + math.sin(angle) * currentRadius;
//
//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         path.lineTo(x, y);
//       }
//     }
//     path.close();
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant GeminiSpherePainter oldDelegate) {
//     // Optimization: Repaint only if animation ticks or audio amplitude changes
//     return oldDelegate.animationValue != animationValue ||
//         oldDelegate.amplitude != amplitude;
//   }
// }
