import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/app_text_field.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_background_auth.dart';

class ForgetPasswordScreenBody extends StatelessWidget {
  const ForgetPasswordScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundAuth(
      crossAxisAlignment: CrossAxisAlignment.center,
      isBack: true,
      children: [
        const RSizedBox(height: 24),
        Text('نسيت كلمة المرور؟', style: AppTextStyles.s24.w700.black),
        const RSizedBox(height: 32),
        Text(
          'ادخل رقم موبايلك أو البريد الإلكتروني المرتبط بالحساب وسنرسل لك رمز تحقق.',
          style: AppTextStyles.s16.w500.subTextNormal,
          textAlign: TextAlign.center,
        ),
        const RSizedBox(height: 48),
        const AppTextField(
          hint: 'ادخل البريد الالكتروني',
          keyboardType: TextInputType.emailAddress,
          isRequired: true,
          label: 'البريد الالكتروني',
          prefixIcon: Icons.email_outlined,
        ),
        const RSizedBox(height: 64),
        AppButton.filled(
          text: 'ارسال',
          onPressed: () {
            showAnimatedTopSnackBar(
              context,
              message: 'تم ارسال الكود بنجاح',
              subMessage: 'افحص بريدك الالكتروني لتجد الكود المرسل',
            );
            context.push(AppRoutes.verifyOTP, extra: true);
          },
        ),
      ],
    );
  }
}
