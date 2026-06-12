import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_elder_data_entity.dart';
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
                  final currentQuestion =
                      controller.surveyQuestions[state.count];

                  if (state.count <= 7) {
                    if (state.answers[controller
                            .surveyQuestions[state.count]
                            .key] !=
                        null) {
                      controller.increment();
                    } else if (currentQuestion.id == 4 ||
                        currentQuestion.id == 5) {
                      if (controller.formKey.currentState!.validate()) {
                        controller.formKey.currentState!.save();
                        controller.increment();
                        if (currentQuestion.id == 4) {
                          controller.updateWeight();
                        }
                        if (currentQuestion.id == 5) {
                          controller.updateHeight();
                        }
                      } else {
                        controller.changeAutoValidateMode();
                      }
                    } else {
                      showAnimatedTopSnackBar(
                        context,
                        message: 'انتبه!',
                        subMessage: 'نسيت ان تجاوب علي السؤال .',
                        isError: true,
                      );
                    }
                  } else {
                    final extra = GoRouterState.of(context).extra;
                    final data = extra as HomeCaregiverElderDataEntity?;
                    if (data != null) {
                      controller.setMedical(data.id);
                    } else {
                      controller.setMedical();
                    }
                  }
                },
              ),
            ),
            BlocListener<MedicalInfoCubit, MedicalInfoState>(
              listener: (context, state) {
                if (state is MedicalInfoSuccess) {
                  if (Navigator.of(context, rootNavigator: true).canPop()) {
                    Navigator.of(context, rootNavigator: true).pop();
                  }

                  showAnimatedTopSnackBar(
                    context,
                    message: 'تم حفظ البيانات بنجاح',
                    subMessage: 'تم اكمال جميع الخطوات',
                  );
                  if (state.appCode == 416) {
                    context.go(AppRoutes.confirmationScreen);
                  } else {
                    context.go(AppRoutes.homeScreenCaregiver);
                  }
                }
                if (state is MedicalInfoFailure) {
                  if (Navigator.of(context, rootNavigator: true).canPop()) {
                    Navigator.of(context, rootNavigator: true).pop();
                  }

                  showAnimatedTopSnackBar(
                    context,
                    isError: true,
                    message: 'في مشكلة',
                    subMessage: state.message,
                  );
                }
                if (state is MedicalInfoLoading) {
                  AppConstant.showLoadingDialog(context);
                }
              },
              child: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
