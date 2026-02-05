part of 'otp_register_cubit.dart';

@immutable
sealed class OtpRegisterState {}

final class OtpRegisterInitial extends OtpRegisterState {}

final class OtpRegisterSuccess extends OtpRegisterState {
  OtpRegisterSuccess(this.entity);
  final OtpVerifyEntity entity;
}

final class OtpResetSuccess extends OtpRegisterState {
  OtpResetSuccess(this.entity);
  final OtpResetEntity entity;
}

final class OtpRegisterLoading extends OtpRegisterState {}

final class OtpRegisterFailure extends OtpRegisterState {
  OtpRegisterFailure(this.message, this.appCode);
  final String message;
  final int? appCode;
}
