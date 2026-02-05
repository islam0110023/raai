part of 'reset_cubit.dart';

@immutable
sealed class ResetState {}

final class ResetInitial extends ResetState {}

final class ResetSuccess extends ResetState {
  ResetSuccess(this.resetEntity);
  final ResetEntity resetEntity;
}

final class ResetLoading extends ResetState {}

final class ResetFailure extends ResetState {
  ResetFailure(this.message, this.appCode);
  final String message;
  final int? appCode;
}
