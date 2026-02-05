part of 'blood_cubit.dart';

@immutable
sealed class BloodState {}

final class BloodInitial extends BloodState {}

final class ReadBloodLoading extends BloodState {}

final class ReadBloodNoData extends BloodState {}

final class ReadBloodSuccess extends BloodState {
  ReadBloodSuccess(this.data);
  final List<BloodReadEntity> data;
}

final class ReadBloodFailure extends BloodState {
  ReadBloodFailure(this.message, this.appCode);
  final String message;
  final int? appCode;
}

final class BloodLoading extends BloodState {}

final class BloodSuccess extends BloodState {}

final class BloodFailure extends BloodState {
  BloodFailure(this.message, this.appCode);
  final String message;
  final int? appCode;
}
