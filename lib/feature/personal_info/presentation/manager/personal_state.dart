part of 'personal_cubit.dart';

@immutable
sealed class PersonalState {}

final class PersonalInitial extends PersonalState {}

final class PersonalLoading extends PersonalState {}

final class PersonalSuccess extends PersonalState {}

final class PersonalFailure extends PersonalState {
  PersonalFailure(this.message, this.appCode);
  final String message;
  final int? appCode;
}
