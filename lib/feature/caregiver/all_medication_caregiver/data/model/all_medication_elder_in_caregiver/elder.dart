import 'package:raai/feature/caregiver/all_medication_caregiver/domain/entity/all_elder_all_medication_caregiver_entity.dart';

class Elder {
  Elder({this.id, this.name});

  factory Elder.fromJson(Map<String, dynamic> json) =>
      Elder(id: json['id'] as int?, name: json['name'] as String?);
  int? id;
  String? name;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
  AllElderAllMedicationCaregiverEntity toEntity() {
    return AllElderAllMedicationCaregiverEntity(id: id ?? 0, name: name ?? '');
  }
}
