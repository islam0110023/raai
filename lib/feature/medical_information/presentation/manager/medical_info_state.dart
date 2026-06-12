part of 'medical_info_cubit.dart';

@immutable
sealed class MedicalInfoState {}

final class MedicalInfoInitial extends MedicalInfoState {}

final class MedicalInfoLoading extends MedicalInfoState {}

final class MedicalInfoSuccess extends MedicalInfoState {
  MedicalInfoSuccess({this.appCode});
  final int? appCode;
}

final class MedicalInfoFailure extends MedicalInfoState {
  MedicalInfoFailure(this.message, this.appCode);

  final String message;
  final int? appCode;
}
