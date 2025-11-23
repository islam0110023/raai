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
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_auth_with_social.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_background_auth.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_chack_box.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundAuth(
      children: [
        Text('انضم وكن في أمان', style: AppTextStyles.s24.w700.textNormal),
        const RSizedBox(height: 24),
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
        const RSizedBox(height: 24),
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
        const AppTextField(
          hint: 'ادخل البريد الالكتروني',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          isRequired: true,
          label: 'البريد الالكتروني',
        ),
        const RSizedBox(height: 16),
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
        const RSizedBox(height: 24),
        AppButton.filled(
          text: 'التسجيل الان',
          onPressed: () {
            showAnimatedTopSnackBar(
              context,
              message: 'تم ارسال الكود بنجاح',
              subMessage: 'افحص بريدك الالكتروني لتجد الكود المرسل',
            );
            context.push(AppRoutes.verifyOTP, extra: false);
          },
        ),
        const RSizedBox(height: 24),
        Align(
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'لدي حساب بالفعل؟ ',
                  style: AppTextStyles.s14.w400.textNormal,
                ),
                TextSpan(
                  text: ' سجل الدخول',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.pop();
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
        const RSizedBox(height: 24),
      ],
    );
  }
}
