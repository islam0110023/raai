import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/auth/presentation/manager/new_password/new_password_cubit.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_background_auth.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_fields_reset_password.dart';

class ResetPasswordScreenBody extends StatelessWidget {
  const ResetPasswordScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<NewPasswordCubit>();
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>;
    final resetRequestId = extra['resetRequestId'];

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
        const CustomFieldsResetPassword(),
        const RSizedBox(height: 64),
        AppButton.filled(
          text: 'تأكيد',
          onPressed: () {
            controller.newPassword(resetToken: resetRequestId);
          },
        ),
        BlocListener<NewPasswordCubit, NewPasswordState>(
          listener: (context, state) {
            if (state is NewPasswordSuccess) {
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }
              showAnimatedTopSnackBar(
                context,
                message: 'تم تغير كلمه المرور بنجاح',
                subMessage: 'الان تستطيع تسجيل الدخول بكلمه المرور الجديده',
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.pop();
                context.pop();
              });
            }
            if (state is NewPasswordFailure) {
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }
              showAnimatedTopSnackBar(
                context,
                message: 'في مشكلة',
                subMessage: state.message,
                isError: true,
              );
            }
            if (state is NewPasswordLoading) {
              AppConstant.showLoadingDialog(context);
            }
          },
          child: const SizedBox.shrink(),
        ),
      ],
    );
  }
}
