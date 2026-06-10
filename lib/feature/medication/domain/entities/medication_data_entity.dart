class MedicationDataEntity {
  MedicationDataEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.form,
    required this.elderId,
    required this.isActive,
    required this.remainingPills,
    required this.pillsPerDose,
    required this.dosesPerDay,
    required this.withFood,
    required this.foodTiming,
    required this.totalPills,
    required this.formIcon,
    required this.dosesPerDayArabicLabel,
    required this.repeatType,
    required this.foodArabicLabel,
  });

  final int id;
  final String name;
  final String category;
  final String? image;
  final String form;
  final int elderId;
  final bool isActive;
  final int remainingPills;
  final int pillsPerDose;
  final int dosesPerDay;
  final int totalPills;
  final bool withFood;
  final String? foodTiming;
  final String formIcon;
  final String dosesPerDayArabicLabel;
  final String repeatType;
  final String foodArabicLabel;
}
