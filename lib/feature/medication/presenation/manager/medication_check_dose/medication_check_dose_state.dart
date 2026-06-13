part of 'medication_check_dose_cubit.dart';

@immutable
sealed class MedicationCheckDoseState {}

final class MedicationCheckDoseInitial extends MedicationCheckDoseState {}

final class MedicationCheckDoseLoading extends MedicationCheckDoseState {}

final class MedicationCheckDoseModelSuccess extends MedicationCheckDoseState {
  MedicationCheckDoseModelSuccess(this.data);

  final TabletModelEntity data;
}

final class MedicationCheckDoseFailure extends MedicationCheckDoseState {
  MedicationCheckDoseFailure(this.message, this.appCode);
  final String message;
  final int? appCode;
}

final class MedicationCheckDoseRememberSuccess
    extends MedicationCheckDoseState {
  MedicationCheckDoseRememberSuccess(this.data);
  final DoNotRememberEntity data;
}
