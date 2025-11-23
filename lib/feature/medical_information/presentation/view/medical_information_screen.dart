import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/medical_information/presentation/manager/medical_info_cubit.dart';
import 'package:raai/feature/medical_information/presentation/view/widget/medical_information_screen_body.dart';

class MedicalInformationScreen extends StatelessWidget {
  const MedicalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MedicalInfoCubit>();
    final state = context.watch<MedicalInfoCubit>();

    return Scaffold(
      body: const MedicalInformationScreenBody(),

      bottomNavigationBar: SafeArea(
        minimum: REdgeInsets.symmetric(horizontal: 16),
        child: Row(
          spacing: 16.w,
          children: [
            Expanded(
              child: AppButton.outline(
                text: state.count == 0 ? 'الرجوع' : 'السابق',
                onPressed: () {
                  if (state.count == 0) {
                    context.pop();
                  } else {
                    controller.decrement();
                  }
                },
              ),
            ),
            Expanded(
              child: AppButton.filled(
                text: 'التالي',
                onPressed: () {
                  if (state.count <= 7) {
                    if (state.answers[controller
                            .surveyQuestions[state.count]
                            .key] !=
                        null || state.count==3||state.count==4) {
                      controller.increment();
                    } else {
                      showAnimatedTopSnackBar(
                        context,
                        message: 'انتبه!',
                        subMessage: 'نسيت ان تجاوب علي السؤال .',
                        isError: true,
                      );
                    }
                  } else {
                    context.go(AppRoutes.confirmationScreen);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
