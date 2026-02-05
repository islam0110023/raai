import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/core/services/token_manager.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/core/widget/app_text_field.dart';
import 'package:raai/core/widget/password_text_field.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/auth/presentation/manager/login/login_cubit.dart';

class CustomFieldsLogin extends StatelessWidget {
  const CustomFieldsLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LoginCubit>();
    final state = context.watch<LoginCubit>();

    return Form(
      key: controller.formKey,
      autovalidateMode: state.autoValidateMode,
      child: Column(
        children: [
          AppTextField(
            hint: 'ادخل رقم الهاتف',
            prefixIcon: CupertinoIcons.phone,
            keyboardType: TextInputType.emailAddress,
            controller: controller.emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يجب ادخال البريد الالكتروني او رقم الهاتف';
              }
              return null;
            },
            isRequired: true,
            label: 'رقم الهاتف',
          ),
          const RSizedBox(height: 16),
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
            helperText: 'يجب ان تكون 8 حروف او ارقام علي الاقل',
          ),
          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                if (Navigator.of(context, rootNavigator: true).canPop()) {
                  Navigator.of(context, rootNavigator: true).pop();
                }
                final tokenManager = getIt<TokenManager>();

                tokenManager.saveAccessToken(state.entity.accessToken);
                final message = ApiErrorMapper.getArabicMessage(
                  state.entity.appCode,
                );

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (state.entity.appCode == 320) {
                    showAnimatedTopSnackBar(
                      context,
                      message: 'كمل بياناتك',
                      subMessage: message,
                    );
                    context.push(AppRoutes.personalInfo);
                  }
                  if (state.entity.appCode == 321) {
                    showAnimatedTopSnackBar(
                      context,
                      message: 'كمل بياناتك',
                      subMessage: message,
                    );
                    context.push(AppRoutes.selectRole);
                  }
                  if (state.entity.appCode == 325) {
                    showAnimatedTopSnackBar(
                      context,
                      message: 'كمل بياناتك',
                      subMessage: message,
                    );
                    context.push(AppRoutes.medicalInfo);
                  }
                  if (state.entity.appCode == 420) {
                    showAnimatedTopSnackBar(
                      context,
                      message: 'انطلق',
                      subMessage: message,
                    );
                    context.go(AppRoutes.homeScreen);
                  }
                });
              }
              if (state is LoginLoading) {
                AppConstant.showLoadingDialog(context);
              }
              if (state is LoginFailure) {
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
      ),
    );
  }
}
