import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_data_entity.dart';

import 'package:raai/feature/caregiver/home_caregiver/data/model/home_caregiver_data_model/caregiver.dart';
import 'package:raai/feature/caregiver/home_caregiver/data/model/home_caregiver_data_model/elder.dart';
import 'package:raai/feature/caregiver/home_caregiver/data/model/home_caregiver_data_model/overview.dart';

class HomeCaregiverDataModel {
  HomeCaregiverDataModel({this.caregiver, this.overview, this.elders});

  factory HomeCaregiverDataModel.fromJson(Map<String, dynamic> json) {
    return HomeCaregiverDataModel(
      caregiver: json['caregiver'] == null
          ? null
          : Caregiver.fromJson(json['caregiver'] as Map<String, dynamic>),
      overview: json['overview'] == null
          ? null
          : Overview.fromJson(json['overview'] as Map<String, dynamic>),
      elders: (json['elders'] as List<dynamic>?)
          ?.map((e) => Elder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  Caregiver? caregiver;
  Overview? overview;
  List<Elder>? elders;

  Map<String, dynamic> toJson() => {
    'caregiver': caregiver?.toJson(),
    'overview': overview?.toJson(),
    'elders': elders?.map((e) => e.toJson()).toList(),
  };
  HomeCaregiverDataEntity toEntity() {
    return HomeCaregiverDataEntity(
      caregiverId: caregiver?.id ?? 0,
      name: caregiver?.fullName ?? '',
      gender: caregiver?.personalData?.gender ?? 'MALE',
      good: overview?.good ?? 0,
      warning: overview?.warning ?? 0,
      critical: overview?.critical ?? 0,
      elders: elders?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
