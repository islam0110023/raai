part of 'add_medication_cubit.dart';

@immutable
sealed class AddMedicationState {}

final class AddMedicationInitial extends AddMedicationState {}

final class AddMedicationLoading extends AddMedicationState {}

final class AddMedicationSuccess extends AddMedicationState {}

final class AddMedicationFailure extends AddMedicationState {
  AddMedicationFailure(this.message, this.appCode);

  final String message;
  final int? appCode;
}
