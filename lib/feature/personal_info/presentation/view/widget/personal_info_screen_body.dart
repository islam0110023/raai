import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/app_text_field.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/personal_info/presentation/manager/personal_cubit.dart';
import 'package:raai/feature/personal_info/presentation/view/widget/custom_container_personal_info_upper.dart';
import 'package:raai/feature/personal_info/presentation/view/widget/custom_image_personal_info.dart';
import 'package:raai/feature/personal_info/presentation/view/widget/custom_select_gender_personal_info.dart';

class PersonalInfoScreenBody extends StatelessWidget {
  const PersonalInfoScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<PersonalCubit>();
    final state = context.watch<PersonalCubit>();
    return Stack(
      children: [
        const CustomContainerPersonalInfoUpper(),
        const CustomImagePersonalInfo(),
        Positioned(
          top: 335.h,
          left: 16.w,
          right: 16.w,
          bottom: 0,
          child: Form(
            key: controller.formKey,
            autovalidateMode: state.autoValidateMode,
            child: SingleChildScrollView(
              padding: REdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    hint: 'ادخل الاسم الاول',
                    label: 'الاسم الاول',
                    isRequired: true,
                    prefixIcon: CupertinoIcons.person,
                    controller: controller.firstName,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'يجب إدخال الاسم الأول';
                      }
                      if (value.trim().length < 2) {
                        return 'الاسم الأول قصير جدًا';
                      }
                      return null;
                    },
                  ),
                  const RSizedBox(height: 16),
                  AppTextField(
                    hint: 'ادخل الاسم الاخير',
                    label: 'الاسم الاخير',
                    isRequired: true,
                    prefixIcon: CupertinoIcons.person,
                    controller: controller.lastName,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'يجب إدخال الاسم الأخير';
                      }
                      if (value.trim().length < 2) {
                        return 'الاسم الأخير قصير جدًا';
                      }
                      return null;
                    },
                  ),
                  const RSizedBox(height: 16),
                  AppTextField(
                    hint: 'حدد تاريخ ميلادك',
                    label: 'تاريخ الميلاد',
                    isRequired: true,
                    prefixIcon: Icons.calendar_today_outlined,
                    controller: controller.birthDate,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يجب تحديد تاريخ الميلاد';
                      }
                      return null;
                    },
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (picked != null) {
                        controller.birthDate.text =
                            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                      }
                    },
                  ),
                  const RSizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      text: 'النوع',
                      style: AppTextStyles.s16.w500.textDark,
                      children: const [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const RSizedBox(height: 16),
                  const CustomSelectGenderPersonalInfo(),
                  const RSizedBox(height: 24),
                  AppButton.filled(
                    text: 'التالي',
                    onPressed: () {
                      controller.setPersonalInfo();
                    },
                  ),
                  BlocListener<PersonalCubit, PersonalState>(
                    listener: (context, state) {
                      if (state is PersonalFailure) {
                        if (Navigator.of(
                          context,
                          rootNavigator: true,
                        ).canPop()) {
                          Navigator.of(context, rootNavigator: true).pop();
                        }

                        showAnimatedTopSnackBar(
                          context,
                          isError: true,
                          message: 'في مشكلة',
                          subMessage: state.message,
                        );
                      }
                      if (state is PersonalSuccess) {
                        if (Navigator.of(
                          context,
                          rootNavigator: true,
                        ).canPop()) {
                          Navigator.of(context, rootNavigator: true).pop();
                        }

                        showAnimatedTopSnackBar(
                          context,
                          message: 'تم حفظ البيانات بنجاح',
                          subMessage: 'كمّل الخطوة التالية',
                        );
                        context.push(AppRoutes.selectRole);
                      }
                      if (state is PersonalLoading) {
                        AppConstant.showLoadingDialog(context);
                      }
                    },
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
