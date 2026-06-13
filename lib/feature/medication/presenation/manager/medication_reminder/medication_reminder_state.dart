part of 'medication_reminder_cubit.dart';

@immutable
sealed class MedicationReminderState {}

final class MedicationReminderInitial extends MedicationReminderState {}

final class MedicationReminderLoading extends MedicationReminderState {}

final class MedicationReminderSuccess extends MedicationReminderState {}

final class MedicationReminderFailure extends MedicationReminderState {
  MedicationReminderFailure(this.message, this.appCode);

  final String message;
  final int? appCode;
}

final class MedicationReminderSnoozeSuccess extends MedicationReminderState {}
