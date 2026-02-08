import 'package:flutter/cupertino.dart';
import 'package:raai/feature/profile/domain/entity/blood_profile_entity.dart';
import 'package:raai/feature/profile/domain/entity/health_profile_entity.dart';
import 'package:raai/feature/profile/domain/entity/personal_data_entity.dart';
import 'package:raai/feature/profile/domain/entity/sugar_profile_entity.dart';

class ProfileUserEntity {
  ProfileUserEntity({
    required this.healthProfile,
    required this.bloodProfile,
    required this.sugarProfile,
    required this.personalData,
    required this.status,
    required this.trafficColor,
    required this.trafficBackgroundColor,
  });

  final HealthProfileEntity healthProfile;
  final BloodProfileEntity? bloodProfile;
  final SugarProfileEntity? sugarProfile;
  final PersonalDataEntity personalData;
  final String status;
  final Color trafficColor;
  final Color trafficBackgroundColor;
}
