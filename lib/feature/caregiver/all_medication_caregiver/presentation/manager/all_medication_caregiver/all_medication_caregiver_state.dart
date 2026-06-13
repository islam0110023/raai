part of 'all_medication_caregiver_cubit.dart';

@immutable
sealed class AllMedicationCaregiverState {}

final class AllMedicationCaregiverInitial extends AllMedicationCaregiverState {}

final class AllMedicationCaregiverLoading extends AllMedicationCaregiverState {}

final class AllMedicationCaregiverSuccess extends AllMedicationCaregiverState {
  AllMedicationCaregiverSuccess(this.data);

  final AllMedicationInCaregiverEntity data;
}

final class AllMedicationCaregiverFailure extends AllMedicationCaregiverState {
  AllMedicationCaregiverFailure(this.message, this.appCode);

  final String message;
  final int? appCode;
}
