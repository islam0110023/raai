import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/bottom_nav/presentation/manager/voice_cubit/voice_cubit.dart';
import 'package:raai/feature/bottom_nav/presentation/view/widget/gemini_sphere_widget.dart';

class CustomBottomSheetVoice extends StatelessWidget {
  const CustomBottomSheetVoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Container(
          padding: REdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColor.white.withAlpha(100),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              const RSizedBox(height: 24),

              BlocSelector<VoiceAssistantCubit, VoiceAssistantState, String>(
                selector: (state) {
                  if (state is VoiceAssistantListening) {
                    return state.recognizedText;
                  }
                  if (state is VoiceAssistantError) {
                    return state.message;
                  }
                  if (state is VoiceAssistantProcessing) {
                    return 'جاري معالجة صوتك وتحليل البيانات الطبية...';
                  }
                  return 'جاري الاستماع...';
                },
                builder: (context, textOutput) {
                  return Text(
                    textOutput,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.s12.w500.white,
                  );
                },
              ),
              const RSizedBox(height: 32),

              Center(
                child:
                    BlocSelector<
                      VoiceAssistantCubit,
                      VoiceAssistantState,
                      double
                    >(
                      selector: (state) => state is VoiceAssistantListening
                          ? state.amplitude
                          : 0.0,
                      builder: (context, currentAmplitude) {
                        return GeminiSphereWidget(amplitude: currentAmplitude);
                      },
                    ),
              ),
              const RSizedBox(height: 32),
              IconButton(
                onPressed: () {
                  context.read<VoiceAssistantCubit>().stopListeningAndAnalyze();
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white54,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
