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
import 'package:raai/feature/auth/presentation/manager/reset/reset_cubit.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_background_auth.dart';

class ForgetPasswordScreenBody extends StatelessWidget {
  const ForgetPasswordScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ResetCubit>();
    final state = context.watch<ResetCubit>();
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
        Form(
          key: controller.formKey,
          autovalidateMode: state.autoValidateMode,
          child: AppTextField(
            hint: 'ادخل البريد الالكتروني',
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
            prefixIcon: Icons.email_outlined,
          ),
        ),
        const RSizedBox(height: 64),
        AppButton.filled(
          text: 'ارسال',
          onPressed: () {
            controller.resetPass();
          },
        ),
        BlocListener<ResetCubit, ResetState>(
          listener: (context, state) {
            if (state is ResetLoading) {
              AppConstant.showLoadingDialog(context);
            }
            if (state is ResetSuccess) {
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }
              showAnimatedTopSnackBar(
                context,
                message: 'تم ارسال الكود بنجاح',
                subMessage: 'افحص بريدك الالكتروني لتجد الكود المرسل',
              );

              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.push(
                  AppRoutes.verifyOTP,
                  extra: {
                    'email': controller.emailController.text,
                    'isForget': 'true',
                    'resetRequestId': state.resetEntity.resetRequestId,
                  },
                );
              });
            }
            if (state is ResetFailure) {
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
          },
          child: const SizedBox.shrink(),
        ),
      ],
    );
  }
}
