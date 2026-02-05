part of 'select_role_cubit.dart';

@immutable
sealed class SelectRoleState {}

final class SelectRoleInitial extends SelectRoleState {}

final class SelectRoleLoading extends SelectRoleState {}

final class SelectRoleSuccess extends SelectRoleState {
  SelectRoleSuccess(this.entity);

  final SelectRoleEntity entity;
}

final class SelectRoleFailure extends SelectRoleState {
  SelectRoleFailure(this.message, this.appCode);

  final String message;
  final int? appCode;
}
