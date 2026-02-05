import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/services/token_manager.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/auth/presentation/manager/otp_register/otp_register_cubit.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_background_auth.dart';
import 'package:raai/feature/auth/presentation/view/widget/o_t_p_text_field.dart';

class VerifyOTPScreenBody extends StatefulWidget {
  const VerifyOTPScreenBody({super.key});

  @override
  State<VerifyOTPScreenBody> createState() => _VerifyOTPScreenBodyState();
}

class _VerifyOTPScreenBodyState extends State<VerifyOTPScreenBody> {
  late TextEditingController otpController;

  @override
  void initState() {
    otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>;
    final email = extra['email'];
    final bool isForget = extra['isForget'] == 'true';
    final controller = context.read<OtpRegisterCubit>();
    final state = context.watch<OtpRegisterCubit>();
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
            'ادخل رمز التحقق الخاص بك المكون من 6 ارقام تم ارساله الي بريدك الالكتروني ${email ?? ''}',
            textAlign: TextAlign.center,
            style: AppTextStyles.s16.w500.subTextNormal,
          ),
          const RSizedBox(height: 64),
          Form(
            key: controller.formKey,
            autovalidateMode: state.autoValidateMode,
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 0.r),
              child: OTPTextField(controller: otpController),
            ),
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
                final resetRequestId = extra['resetRequestId'] as int;
                controller.otpReset(resetRequestId, otpController.text);
              } else {
                controller.otpVerify(otpController.text);
              }
            },
          ),
          BlocListener<OtpRegisterCubit, OtpRegisterState>(
            listener: (context, state) {
              if (state is OtpRegisterSuccess) {
                if (Navigator.of(context, rootNavigator: true).canPop()) {
                  Navigator.of(context, rootNavigator: true).pop();
                }
                showAnimatedTopSnackBar(
                  context,
                  message: 'تم التحقق بنجاح',
                  subMessage: 'كمّل بياناتك الشخصية',
                );
                final tokenManager = getIt<TokenManager>();

                tokenManager.saveAccessToken(state.entity.accessToken);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.replace(AppRoutes.personalInfo);
                });
              }
              if (state is OtpResetSuccess) {
                if (Navigator.of(context, rootNavigator: true).canPop()) {
                  Navigator.of(context, rootNavigator: true).pop();
                }
                showAnimatedTopSnackBar(
                  context,
                  message: 'تم التحقق بنجاح',
                  subMessage: 'تقدر تغير كلمة السر',
                );
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.replace(
                    AppRoutes.resetPassword,
                    extra: {'resetRequestId': state.entity.resetToken},
                  );
                });
              }
              if (state is OtpRegisterFailure) {
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
              if (state is OtpRegisterLoading) {
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
