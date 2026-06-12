part of 'home_caregiver_cubit.dart';

@immutable
sealed class HomeCaregiverState {}

final class HomeCaregiverInitial extends HomeCaregiverState {}

final class HomeCaregiverLoading extends HomeCaregiverState {}

final class HomeCaregiverSuccess extends HomeCaregiverState {
  HomeCaregiverSuccess(this.data);

  final HomeCaregiverDataEntity data;
}

final class HomeCaregiverFailure extends HomeCaregiverState {
  HomeCaregiverFailure(this.message, this.appCode);

  final String message;
  final int? appCode;
}
