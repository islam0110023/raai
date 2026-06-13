class MedicationReminderEntity {
  MedicationReminderEntity({
    required this.image,
    required this.form,
    required this.name,
    required this.pillsPerDose,
    required this.withFood,
    required this.foodTiming,
    required this.scheduledTime,
    required this.doseId,
    required this.id,
  });

  final String? image;
  final String? form;
  final String name;
  final int pillsPerDose;
  final bool withFood;
  final String? foodTiming;
  final DateTime scheduledTime;
  final int doseId;
  final int id;
}
