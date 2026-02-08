import 'package:raai/feature/profile/domain/entity/health_profile_entity.dart';

class HealthProfile {
  HealthProfile({
    this.id,
    this.userId,
    this.hypertension,
    this.heartDisease,
    this.diabetes,
    this.weightKg,
    this.heightCm,
    this.smokingStatus,
    this.activityLevel,
    this.familyHistory,
    this.sleepQuality,
    this.createdAt,
    this.updatedAt,
  });

  factory HealthProfile.fromJson(Map<String, dynamic> json) => HealthProfile(
    id: json['id'] as int?,
    userId: json['userId'] as int?,
    hypertension: json['hypertension'] as bool?,
    heartDisease: json['heartDisease'] as bool?,
    diabetes: json['diabetes'] as String?,
    weightKg: json['weightKg'] as int?,
    heightCm: json['heightCm'] as int?,
    smokingStatus: json['smokingStatus'] as String?,
    activityLevel: json['activityLevel'] as String?,
    familyHistory: json['familyHistory'] as String?,
    sleepQuality: json['sleepQuality'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );
  int? id;
  int? userId;
  bool? hypertension;
  bool? heartDisease;
  String? diabetes;
  int? weightKg;
  int? heightCm;
  String? smokingStatus;
  String? activityLevel;
  String? familyHistory;
  String? sleepQuality;
  DateTime? createdAt;
  DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'hypertension': hypertension,
    'heartDisease': heartDisease,
    'diabetes': diabetes,
    'weightKg': weightKg,
    'heightCm': heightCm,
    'smokingStatus': smokingStatus,
    'activityLevel': activityLevel,
    'familyHistory': familyHistory,
    'sleepQuality': sleepQuality,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
  HealthProfileEntity toEntity() {
    return HealthProfileEntity(
      id: id!,
      userId: userId!,
      hypertension: hypertension!,
      heartDisease: heartDisease!,
      diabetes: diabetes!,
      weightKg: weightKg!,
      heightCm: heightCm!,
      smokingStatus: smokingStatus!,
      activityLevel: activityLevel!,
      familyHistory: familyHistory!,
      sleepQuality: sleepQuality!,
    );
  }
}
