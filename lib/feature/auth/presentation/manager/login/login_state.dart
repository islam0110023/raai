part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {
  LoginSuccess(this.entity);
  final LoginEntity entity;
}

final class LoginLoading extends LoginState {}

final class LoginFailure extends LoginState {
  LoginFailure(this.message, this.appCode);
  final String message;
  final int? appCode;
}
