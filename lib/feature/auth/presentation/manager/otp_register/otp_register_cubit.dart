import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/core/secure_storage/secure_storage.dart';
import 'package:raai/feature/auth/domain/entity/otp_reset_entity.dart';
import 'package:raai/feature/auth/domain/entity/otp_verify_entity.dart';
import 'package:raai/feature/auth/domain/use_case/otp_reset_use_case.dart';
import 'package:raai/feature/auth/domain/use_case/otp_verify_use_case.dart';

part 'otp_register_state.dart';

class OtpRegisterCubit extends Cubit<OtpRegisterState> {
  OtpRegisterCubit(
    this.otpVerifyUseCase,
    this.emailController,
    this.otpResetUseCase,
  ) : super(OtpRegisterInitial());
  final OtpVerifyUseCase otpVerifyUseCase;
  final OtpResetUseCase otpResetUseCase;
  final String emailController;
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  void otpVerify(String otp) async {
    if (formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.disabled;
      formKey.currentState!.save();
      emit(OtpRegisterLoading());

      final result = await otpVerifyUseCase(email: emailController, otp: otp);

      result.fold(
        (failure) {
          final message = ApiErrorMapper.getArabicMessage(failure.appCode);

          emit(OtpRegisterFailure(message, failure.appCode));
        },
        (data) {
          SecureStorage.saveUserToken(token: data.refreshToken)
              .then((value) {
                emit(OtpRegisterSuccess(data));
              })
              .onError((error, stackTrace) {
                emit(OtpRegisterFailure('حدث خطأ غير متوقع', null));
              });
        },
      );
    } else {
      autoValidateMode = AutovalidateMode.always;
      emit(OtpRegisterInitial());
    }
  }

  void otpReset(int resetRequestId, String otp) async {
    if (formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.disabled;
      formKey.currentState!.save();
      emit(OtpRegisterLoading());

      final result = await otpResetUseCase(
        resetRequestId: resetRequestId,
        otp: otp,
      );

      result.fold(
        (failure) {
          final message = ApiErrorMapper.getArabicMessage(failure.appCode);

          emit(OtpRegisterFailure(message, failure.appCode));
        },
        (data) {
          emit(OtpResetSuccess(data));
        },
      );
    } else {
      autoValidateMode = AutovalidateMode.always;
      emit(OtpRegisterInitial());
    }
  }
}
