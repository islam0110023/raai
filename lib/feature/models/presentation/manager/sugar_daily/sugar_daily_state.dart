part of 'sugar_daily_cubit.dart';

@immutable
sealed class SugarDailyState {}

final class SugarDailyInitial extends SugarDailyState {}

final class SugarDailyLoading extends SugarDailyState {}

final class SugarDailySuccess extends SugarDailyState {
  SugarDailySuccess(this.data);
  final SugarDailyEntity data;
}

final class SugarDailyFailure extends SugarDailyState {
  SugarDailyFailure(this.message, this.appCode);
  final String message;
  final int? appCode;
}
