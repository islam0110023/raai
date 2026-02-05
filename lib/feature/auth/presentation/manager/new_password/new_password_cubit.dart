import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/auth/domain/use_case/new_password_use_case.dart';

part 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit(this.newPasswordUseCase) : super(NewPasswordInitial()) {
    init();
  }
  final NewPasswordUseCase newPasswordUseCase;
  late GlobalKey<FormState> formKey;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late TextEditingController passwordController;
  void init() {
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  void newPassword({required String resetToken}) async {
    if (!formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.always;
      emit(NewPasswordInitial());
      return;
    } else {
      autoValidateMode = AutovalidateMode.disabled;
      formKey.currentState!.save();
      emit(NewPasswordLoading());
      final result = await newPasswordUseCase.call(
        resetToken: resetToken,
        password: passwordController.text,
      );
      result.fold(
        (failure) {
          final message = ApiErrorMapper.getArabicMessage(failure.appCode);

          emit(NewPasswordFailure(message, failure.appCode));
        },
        (data) {
          emit(NewPasswordSuccess());
        },
      );
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    passwordController.dispose();
    return super.close();
  }
}
