part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoading extends ProfileState {}
final class ProfileSuccess extends ProfileState {

  ProfileSuccess(this.profile);
  final ProfileUserEntity profile;
}
final class ProfileFailure extends ProfileState {
  ProfileFailure(this.message, this.appCode);
  final String message;
  final int? appCode;
}
