import 'package:raai/feature/caregiver/all_medication_caregiver/data/model/all_medication_elder_in_caregiver/dose.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/data/model/all_medication_elder_in_caregiver/elder.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/data/model/all_medication_elder_in_caregiver/summary.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/entity/all_medication_in_caregiver_entity.dart';

class AllMedicationElderInCaregiverModel {
  factory AllMedicationElderInCaregiverModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AllMedicationElderInCaregiverModel(
      summary: json['summary'] == null
          ? null
          : Summary.fromJson(json['summary'] as Map<String, dynamic>),
      elders: (json['elders'] as List<dynamic>?)
          ?.map((e) => Elder.fromJson(e as Map<String, dynamic>))
          .toList(),
      doses: (json['doses'] as List<dynamic>?)
          ?.map((e) => Dose.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  AllMedicationElderInCaregiverModel({this.summary, this.elders, this.doses});
  Summary? summary;
  List<Elder>? elders;
  List<Dose>? doses;

  Map<String, dynamic> toJson() => {
    'summary': summary?.toJson(),
    'elders': elders?.map((e) => e.toJson()).toList(),
    'doses': doses?.map((e) => e.toJson()).toList(),
  };
  AllMedicationInCaregiverEntity toEntity() {
    return AllMedicationInCaregiverEntity(
      taken: summary?.taken ?? 0,
      missed: summary?.missed ?? 0,
      upcoming: summary?.upcoming ?? 0,
      snoozed: summary?.snoozed ?? 0,
      elders: elders?.map((e) => e.toEntity()).toList() ?? [],
      doses: doses?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
