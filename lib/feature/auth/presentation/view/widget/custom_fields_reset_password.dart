import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/widget/password_text_field.dart';
import 'package:raai/feature/auth/presentation/manager/new_password/new_password_cubit.dart';

class CustomFieldsResetPassword extends StatelessWidget {
  const CustomFieldsResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<NewPasswordCubit>();
    final state = context.watch<NewPasswordCubit>();
    return Form(
      key: controller.formKey,
      autovalidateMode: state.autoValidateMode,
      child: Column(
        children: [
          const RSizedBox(height: 48),
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
        ],
      ),
    );
  }
}
