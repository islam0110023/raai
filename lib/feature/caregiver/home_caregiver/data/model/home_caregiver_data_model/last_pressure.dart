import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_elder_pressure_entity.dart';

class LastPressure {
  LastPressure({this.sys, this.dia, this.status, this.recordedAt});

  factory LastPressure.fromJson(Map<String, dynamic> json) => LastPressure(
    sys: json['sys'] as int?,
    dia: json['dia'] as int?,
    status: json['status'] as String?,
    recordedAt: json['recordedAt'] == null
        ? null
        : DateTime.parse(json['recordedAt'] as String),
  );
  int? sys;
  int? dia;
  String? status;
  DateTime? recordedAt;

  Map<String, dynamic> toJson() => {
    'sys': sys,
    'dia': dia,
    'status': status,
    'recordedAt': recordedAt?.toIso8601String(),
  };
  HomeCaregiverElderPressureEntity toEntity() {
    return HomeCaregiverElderPressureEntity(
      sys: sys ?? 0,
      dia: dia ?? 0,
      status: status ?? '',
    );
  }
}
