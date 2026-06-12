import 'package:raai/feature/caregiver/profile_caregiver/domain/entity/profile_caregiver_data_entity.dart';

import 'package:raai/feature/caregiver/profile_caregiver/data/model/profile_caregiver_model/profile.dart';
import 'package:raai/feature/caregiver/profile_caregiver/data/model/profile_caregiver_model/statistics.dart';

class ProfileCaregiverModel {
  ProfileCaregiverModel({this.profile, this.statistics});

  factory ProfileCaregiverModel.fromJson(Map<String, dynamic> json) {
    return ProfileCaregiverModel(
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      statistics: json['statistics'] == null
          ? null
          : Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
    );
  }
  Profile? profile;
  Statistics? statistics;

  Map<String, dynamic> toJson() => {
    'profile': profile?.toJson(),
    'statistics': statistics?.toJson(),
  };
  ProfileCaregiverDataEntity toEntity() {
    return ProfileCaregiverDataEntity(
      id: profile!.id!,
      gender: profile?.personalData?.gender ?? 'MALE',
      fullName: profile?.fullName ?? '',
      phone: profile?.phone ?? '',
      elderCount: statistics?.eldersCount ?? 0,
    );
  }
}
