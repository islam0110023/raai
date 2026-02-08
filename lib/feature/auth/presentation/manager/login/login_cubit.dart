import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/db/cache_helper/cache_helper.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/core/secure_storage/secure_storage.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/feature/auth/domain/entity/login_entity.dart';
import 'package:raai/feature/auth/domain/use_case/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(LoginInitial());
  final LoginUseCase loginUseCase;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  void login() async {
    if (formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.disabled;
      formKey.currentState!.save();
      emit(LoginLoading());
      final result = await loginUseCase.call(
        email: emailController.text,
        password: passwordController.text,
      );
      result.fold(
        (failure) {
          final message = ApiErrorMapper.getArabicMessage(failure.appCode);

          emit(LoginFailure(message, failure.appCode));
        },
        (data) async {
          try {
            await SecureStorage.saveUserToken(token: data.refreshToken);

            if (data.appCode == 420) {
              await CacheHelper.saveData(
                key: AppConstant.cacheKeyIsLoggedIn,
                value: true,
              );
            }
            if (data.appCode == 452) {
              await CacheHelper.saveData(
                key: AppConstant.cacheKeyCaregiverIsLoggedIn,
                value: true,
              );
            }

            emit(LoginSuccess(data));
          } catch (_) {
            emit(LoginFailure('حدث خطأ غير متوقع', null));
          }
        },
      );
    } else {
      autoValidateMode = AutovalidateMode.always;
      emit(LoginInitial());
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
