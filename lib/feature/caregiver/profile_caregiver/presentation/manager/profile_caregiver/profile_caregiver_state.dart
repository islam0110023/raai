part of 'profile_caregiver_cubit.dart';

@immutable
sealed class ProfileCaregiverState {}

final class ProfileCaregiverInitial extends ProfileCaregiverState {}

final class ProfileCaregiverLoading extends ProfileCaregiverState {}

final class ProfileCaregiverSuccess extends ProfileCaregiverState {
  ProfileCaregiverSuccess(this.data);

  final ProfileCaregiverDataEntity data;
}

final class ProfileCaregiverFailure extends ProfileCaregiverState {
  ProfileCaregiverFailure(this.message, this.appCode);

  final String message;
  final int? appCode;
}
