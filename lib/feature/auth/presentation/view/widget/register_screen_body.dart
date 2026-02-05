import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/feature/auth/presentation/manager/register/register_cubit.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_auth_with_social.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_background_auth.dart';
import 'package:raai/feature/auth/presentation/view/widget/form_fields_register.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<RegisterCubit>();
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
        const FormFieldsRegister(),
        const RSizedBox(height: 24),
        AppButton.filled(
          text: 'التسجيل الان',
          onPressed: () {
            controller.register();
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
