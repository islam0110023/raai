import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_elder_pressure_entity.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_elder_status_data_entity.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_elder_sugar_entity.dart';

class HomeCaregiverElderDataEntity {
  HomeCaregiverElderDataEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.role,
    required this.healthProfileCompleted,
    required this.lastActivity,
    required this.status,
    required this.lastPressure,
    required this.lastSugar,
    required this.gender,
  });

  final int id;
  final String name;
  final int age;
  final String role;
  final bool healthProfileCompleted;
  final DateTime lastActivity;
  final HomeCaregiverElderStatusDataEntity status;
  final HomeCaregiverElderPressureEntity lastPressure;
  final HomeCaregiverElderSugarEntity lastSugar;
  final String gender;
}
