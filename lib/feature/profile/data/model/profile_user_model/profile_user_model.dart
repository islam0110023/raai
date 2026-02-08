import 'package:raai/feature/profile/data/model/profile_user_model/health_profile.dart';
import 'package:raai/feature/profile/data/model/profile_user_model/last_readings.dart';
import 'package:raai/feature/profile/data/model/profile_user_model/ovarall_health.dart';
import 'package:raai/feature/profile/data/model/profile_user_model/personal_data.dart';
import 'package:raai/feature/profile/domain/entity/profile_user_entity.dart';

class ProfileUserModel {
  ProfileUserModel({this.personalData, this.healthProfile, this.lastReadings});

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      personalData: json['personalData'] == null
          ? null
          : PersonalData.fromJson(json['personalData'] as Map<String, dynamic>),
      healthProfile: json['healthProfile'] == null
          ? null
          : HealthProfile.fromJson(
              json['healthProfile'] as Map<String, dynamic>,
            ),
      lastReadings: json['lastReadings'] == null
          ? null
          : LastReadings.fromJson(json['lastReadings'] as Map<String, dynamic>),
    );
  }
  PersonalData? personalData;
  HealthProfile? healthProfile;
  LastReadings? lastReadings;

  Map<String, dynamic> toJson() => {
    'personalData': personalData?.toJson(),
    'healthProfile': healthProfile?.toJson(),
    'lastReadings': lastReadings?.toJson(),
  };
  ProfileUserEntity toEntity() {
    return ProfileUserEntity(
      healthProfile: healthProfile!.toEntity(),
      bloodProfile: lastReadings?.bloodPressure?.toEntity(),
      sugarProfile: lastReadings?.sugar?.toEntity(),
      personalData: personalData!.toEntity(),
      status: (
        sugar: lastReadings?.sugar?.status,
        blood: lastReadings?.bloodPressure?.status,
      ).overallArabicLabel,
      trafficColor: (
        sugar: lastReadings?.sugar?.status,
        blood: lastReadings?.bloodPressure?.status,
      ).overallColor,
      trafficBackgroundColor: (
        sugar: lastReadings?.sugar?.status,
        blood: lastReadings?.bloodPressure?.status,
      ).overallBackgroundColor,
    );
  }
}
