import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_text_field.dart';
import 'package:raai/core/widget/password_text_field.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/auth/presentation/manager/register/register_cubit.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_chack_box.dart';

class FormFieldsRegister extends StatelessWidget {
  const FormFieldsRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<RegisterCubit>();
    final state = context.watch<RegisterCubit>();

    return Form(
      key: controller.formKey,
      autovalidateMode: state.autoValidateMode,
      child: Column(
        children: [
          AppTextField(
            hint: 'ادخل رقم الهاتف',
            prefixIcon: CupertinoIcons.phone,
            keyboardType: TextInputType.phone,
            controller: controller.phoneController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يجب ادخال هذا الحقل';
              }
              if (value.length < 11) {
                return 'يجب أن يتكون رقم الهاتف من 11 رقماً على الأقل';
              }
              if (value.length > 11) {
                return 'يجب ألا يتجاوز رقم الهاتف 11 رقماً';
              }
              return null;
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            isRequired: true,
            label: 'رقم الهاتف',
          ),
          const RSizedBox(height: 16),
          AppTextField(
            hint: 'ادخل البريد الالكتروني',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            isRequired: true,
            controller: controller.emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يجب ادخال البريد الالكتروني';
              }
              return null;
            },
            label: 'البريد الالكتروني',
          ),
          const RSizedBox(height: 16),
          PasswordTextField(
            hint: 'ادخل كلمه المرور الخاصه بك',
            isRequired: true,
            label: 'كلمه المرور',
            controller: controller.passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يجب ادخال كلمة المرور';
              }
              if (value.length < 8) {
                return 'كلمة المرور يجب ألا تقل عن 8 أحرف';
              }
              return null;
            },
          ),
          const RSizedBox(height: 16),
          PasswordTextField(
            hint: 'ادخل كلمه المرور الخاصه بك',
            isRequired: true,
            label: 'تأكيد كلمه المرور',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يجب تأكيد كلمة المرور';
              }
              if (value != controller.passwordController.text) {
                return 'كلمة المرور غير متطابقة';
              }
              return null;
            },
          ),
          const RSizedBox(height: 16),
          Row(
            children: [
              const CustomCheckBox(),
              Align(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'أوافق علي كل ',
                        style: AppTextStyles.s14.w400.textNormal,
                      ),
                      TextSpan(
                        text: 'الشروط و الاحكام',
                        style: AppTextStyles.s14.w400.primaryNormal.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColor.primaryNormal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                if (Navigator.of(context, rootNavigator: true).canPop()) {
                  Navigator.of(context, rootNavigator: true).pop();
                }
                showAnimatedTopSnackBar(
                  context,
                  message: 'تم ارسال الكود بنجاح',
                  subMessage: 'افحص بريدك الالكتروني لتجد الكود المرسل',
                );
                context.push(
                  AppRoutes.verifyOTP,
                  extra: {
                    'email': controller.emailController.text,
                    'isForget': 'false',
                  },
                );
              }
              if (state is RegisterError) {
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
              if (state is RegisterLoading) {
                AppConstant.showLoadingDialog(context);
              }
            },
            child: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
