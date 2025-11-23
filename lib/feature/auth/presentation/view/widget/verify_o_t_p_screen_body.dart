import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_background_auth.dart';
import 'package:raai/feature/auth/presentation/view/widget/o_t_p_text_field.dart';

class VerifyOTPScreenBody extends StatelessWidget {
  const VerifyOTPScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isForget = GoRouterState.of(context).extra as bool;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: CustomBackgroundAuth(
        crossAxisAlignment: CrossAxisAlignment.center,
        isBack: true,
        children: [
          const RSizedBox(height: 24),
          Text(
            'رمز التحقق',
            textAlign: TextAlign.center,
            style: AppTextStyles.s24.w700.black,
          ),
          const RSizedBox(height: 32),
          Text(
            'ادخل رمز التحقق الخاص بك المكون من 4 ارقام تم ارساله الي بريدك الالكتروني example@gmail.com',
            textAlign: TextAlign.center,
            style: AppTextStyles.s16.w500.subTextNormal,
          ),
          const RSizedBox(height: 64),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 31.5.r),
            child: const OTPTextField(),
          ),
          const RSizedBox(height: 32),
          Align(
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'لم تستلم الكود؟ ',
                    style: AppTextStyles.s14.w400.textNormal,
                  ),
                  TextSpan(
                    text: 'اعاده الارسال',
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: AppTextStyles.s14.w400.primaryNormal.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.primaryNormal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const RSizedBox(height: 80),
          AppButton.filled(
            text: 'تحقق',
            onPressed: () {
              if (isForget) {
                context.replace(AppRoutes.resetPassword);
              } else {
                context.replace(AppRoutes.personalInfo);
              }
            },
          ),
        ],
      ),
    );
  }
}
