import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/password_text_field.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_background_auth.dart';

class ResetPasswordScreenBody extends StatelessWidget {
  const ResetPasswordScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundAuth(
      isBack: true,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const RSizedBox(height: 24),
        Text('أدخل كلمة مرور جديدة', style: AppTextStyles.s24.w700.black),
        const RSizedBox(height: 32),
        Text(
          'اختَر كلمة قوية، لا تقل عن 8 أحرف.',
          style: AppTextStyles.s16.w500.subTextNormal,
        ),
        const RSizedBox(height: 48),
        const PasswordTextField(
          hint: 'ادخل كلمه المرور الخاصه بك',
          isRequired: true,
          label: 'كلمه المرور',
        ),
        const RSizedBox(height: 16),
        const PasswordTextField(
          hint: 'ادخل كلمه المرور الخاصه بك',
          isRequired: true,
          label: 'تأكيد كلمه المرور',
        ),
        const RSizedBox(height: 64),
        AppButton.filled(
          text: 'تأكيد',
          onPressed: () {
            showAnimatedTopSnackBar(
              context,
              message: 'تم تغير كلمه المرور بنجاح',
              subMessage: 'الان تستطيع تسجيل الدخول بكلمه المرور الجديده',
            );
            context.pop();
            context.pop();
          },
        ),
      ],
    );
  }
}
