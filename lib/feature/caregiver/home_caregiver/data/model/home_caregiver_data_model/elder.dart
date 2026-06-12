import 'package:raai/core/utils/app_color.dart';
import 'package:raai/feature/caregiver/home_caregiver/data/model/home_caregiver_data_model/last_pressure.dart';
import 'package:raai/feature/caregiver/home_caregiver/data/model/home_caregiver_data_model/last_sugar.dart';
import 'package:raai/feature/caregiver/home_caregiver/data/model/home_caregiver_data_model/status.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_elder_data_entity.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_elder_pressure_entity.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_elder_status_data_entity.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_elder_sugar_entity.dart';

class Elder {
  factory Elder.fromJson(Map<String, dynamic> json) => Elder(
    id: json['id'] as int?,
    name: json['name'] as String?,
    age: json['age'] as int?,
    role: json['role'] as String?,
    healthProfileCompleted: json['healthProfileCompleted'] as bool?,
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
    lastPressure: json['lastPressure'] == null
        ? null
        : LastPressure.fromJson(json['lastPressure'] as Map<String, dynamic>),
    lastSugar: json['lastSugar'] == null
        ? null
        : LastSugar.fromJson(json['lastSugar'] as Map<String, dynamic>),
    lastActivity: json['lastActivity'] == null
        ? null
        : DateTime.parse(json['lastActivity'] as String),
    gender: json['gender'] as String?,
    birthDate: json['birthDate'] as String?,
  );

  Elder({
    this.id,
    this.name,
    this.age,
    this.role,
    this.healthProfileCompleted,
    this.status,
    this.lastPressure,
    this.lastSugar,
    this.lastActivity,
    this.gender,
    this.birthDate,
  });
  int? id;
  String? name;
  int? age;
  String? role;
  bool? healthProfileCompleted;
  Status? status;
  LastPressure? lastPressure;
  LastSugar? lastSugar;
  DateTime? lastActivity;
  String? gender;
  String? birthDate;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'age': age,
    'role': role,
    'healthProfileCompleted': healthProfileCompleted,
    'status': status?.toJson(),
    'lastPressure': lastPressure?.toJson(),
    'lastSugar': lastSugar?.toJson(),
    'lastActivity': lastActivity?.toIso8601String(),
  };
  HomeCaregiverElderDataEntity toEntity() {
    return HomeCaregiverElderDataEntity(
      id: id ?? 0,
      name: name ?? '',
      age: age ?? 0,
      role: role ?? '',
      lastActivity: lastActivity ?? DateTime.now(),
      healthProfileCompleted: healthProfileCompleted ?? false,
      status:
          status?.toEntity() ??
          HomeCaregiverElderStatusDataEntity(
            code: '',
            label: 'لم يحدد بعد',
            trafficColor: AppColor.subtextNormal,
          ),
      lastPressure:
          lastPressure?.toEntity() ??
          HomeCaregiverElderPressureEntity(sys: 0, dia: 0, status: ''),
      lastSugar:
          lastSugar?.toEntity() ??
          HomeCaregiverElderSugarEntity(value: 0, status: ''),
      gender: gender ?? 'MALE',
    );
  }
}
