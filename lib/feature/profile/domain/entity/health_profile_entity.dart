class HealthProfileEntity {
  HealthProfileEntity({
    required this.id,
    required this.userId,
    required this.hypertension,
    required this.heartDisease,
    required this.diabetes,
    required this.weightKg,
    required this.heightCm,
    required this.smokingStatus,
    required this.activityLevel,
    required this.familyHistory,
    required this.sleepQuality,
  });

  final int id;
  final int userId;
  final bool hypertension;
  final bool heartDisease;
  final String diabetes;
  final int weightKg;
  final int heightCm;
  final String smokingStatus;
  final String activityLevel;
  final String familyHistory;
  final String sleepQuality;
}
