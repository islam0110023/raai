part of 'sugar_monthly_cubit.dart';

@immutable
sealed class SugarMonthlyState {}

final class SugarMonthlyInitial extends SugarMonthlyState {}

final class SugarMonthlyLoading extends SugarMonthlyState {}

final class SugarMonthlySuccess extends SugarMonthlyState {
  SugarMonthlySuccess(this.data);
  final SugarMonthlyEntity data;
}

final class SugarMonthlyFailure extends SugarMonthlyState {
  SugarMonthlyFailure(this.message, this.appCode);
  final String message;
  final int? appCode;
}
