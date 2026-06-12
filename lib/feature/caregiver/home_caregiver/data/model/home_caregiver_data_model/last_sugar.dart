import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_elder_sugar_entity.dart';

class LastSugar {
  factory LastSugar.fromJson(Map<String, dynamic> json) => LastSugar(
    value: json['value'] as int?,
    status: json['status'] as String?,
    recordedAt: json['recordedAt'] == null
        ? null
        : DateTime.parse(json['recordedAt'] as String),
  );

  LastSugar({this.value, this.status, this.recordedAt});
  int? value;
  String? status;
  DateTime? recordedAt;

  Map<String, dynamic> toJson() => {
    'value': value,
    'status': status,
    'recordedAt': recordedAt?.toIso8601String(),
  };
  HomeCaregiverElderSugarEntity toEntity() {
    return HomeCaregiverElderSugarEntity(
      value: value ?? 0,
      status: status ?? '',
    );
  }
}
