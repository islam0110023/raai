class AllDosesAllMedicationCaregiver {
  AllDosesAllMedicationCaregiver({
    required this.doseId,
    required this.elderId,
    required this.name,
    required this.medicationId,
    required this.medicationName,
    required this.medicationType,
    required this.medicationImage,
    required this.scheduledTime,
    required this.nextReminderTime,
    required this.isTaken,
    required this.statusCode,
    required this.canSendReminder,
  });

  final int doseId;
  final int elderId;
  final String name;
  final int medicationId;
  final String medicationName;
  final String? medicationType;
  final String medicationImage;
  final DateTime scheduledTime;
  final DateTime? nextReminderTime;
  final bool isTaken;
  final String statusCode;
  final bool canSendReminder;
}
