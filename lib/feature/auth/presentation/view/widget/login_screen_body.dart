import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/app_text_field.dart';
import 'package:raai/core/widget/password_text_field.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_auth_with_social.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_background_auth.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundAuth(
      children: [
        Text('اهلا بعودتك', style: AppTextStyles.s24.w700.black),
        const RSizedBox(height: 30),
        Text('سجل باستخدام:', style: AppTextStyles.s16.w500.textNormal),
        const RSizedBox(height: 16),
        Row(
          spacing: 16.w,
          children: const [
            Expanded(
              child: CustomAuthWithSocial(
                name: 'فيسبوك',
                image: AppIcons.facebook,
              ),
            ),
            Expanded(
              child: CustomAuthWithSocial(name: 'جوجل', image: AppIcons.google),
            ),
          ],
        ),
        const RSizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppColor.subtextNormal,
                endIndent: 10.w,
                indent: 10.w,
              ),
            ),
            Text('او', style: AppTextStyles.s16.w500.textNormal),
            Expanded(
              child: Divider(
                color: AppColor.subtextNormal,
                endIndent: 10.w,
                indent: 10.w,
              ),
            ),
          ],
        ),
        const RSizedBox(height: 16),
        AppTextField(
          hint: 'ادخل رقم الهاتف',
          prefixIcon: CupertinoIcons.phone,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          isRequired: true,
          label: 'رقم الهاتف',
        ),
        const RSizedBox(height: 16),
        const PasswordTextField(
          hint: 'ادخل كلمه المرور الخاصه بك',
          isRequired: true,
          label: 'كلمه المرور',
          helperText: 'يجب ان تكون 8 حروف او ارقام علي الاقل',
        ),
        TextButton(
          onPressed: () {
            context.push(AppRoutes.forgetScreen);
          },
          style: TextButton.styleFrom(shadowColor: AppColor.primaryLightHover),
          child: Text(
            'نسيت كلمه المرور؟',
            style: AppTextStyles.s14.w400.primaryNormal.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: AppColor.primaryNormal,
            ),
          ),
        ),
        const RSizedBox(height: 20),
        AppButton.filled(text: 'تسجيل الدخول', onPressed: () {}),
        const RSizedBox(height: 16),
        Align(
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'ليس لديك حساب؟ ',
                  style: AppTextStyles.s14.w400.textNormal,
                ),
                TextSpan(
                  text: 'سجل الأن',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.push(AppRoutes.register);
                    },
                  style: AppTextStyles.s14.w400.primaryNormal.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.primaryNormal,
                  ),
                ),
              ],
            ),
          ),
        ),
        const RSizedBox(height: 40),
      ],
    );
  }
}
