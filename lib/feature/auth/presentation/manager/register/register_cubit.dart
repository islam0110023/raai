import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/auth/domain/use_case/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.registerUseCase) : super(RegisterInitial());
  final RegisterUseCase registerUseCase;

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.always;
      emit(RegisterInitial());
      return;
    } else {
      autoValidateMode = AutovalidateMode.disabled;
      formKey.currentState!.save();
      emit(RegisterLoading());
      final result = await registerUseCase.call(
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      );
      result.fold(
        (failure) {
          final message = ApiErrorMapper.getArabicMessage(failure.appCode);
          emit(RegisterError(message, failure.appCode));
        },
        (data) {
          emit(RegisterSuccess());
        },
      );
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
