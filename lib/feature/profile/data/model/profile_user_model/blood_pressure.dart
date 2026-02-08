import 'package:raai/feature/profile/domain/entity/blood_profile_entity.dart';
import 'package:raai/feature/reads/data/model/blood_read_model/blood_status.dart';

class BloodPressure {
  BloodPressure({
    this.id,
    this.idCard,
    this.sys,
    this.dia,
    this.status,
    this.recordedAt,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory BloodPressure.fromJson(Map<String, dynamic> json) => BloodPressure(
    id: json['id'] as int?,
    idCard: json['idCard'] as String?,
    sys: json['sys'] as int?,
    dia: json['dia'] as int?,
    status: json['status'] as String?,
    recordedAt: json['recordedAt'] == null
        ? null
        : DateTime.parse(json['recordedAt'] as String),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    userId: json['userId'] as int?,
  );
  int? id;
  String? idCard;
  int? sys;
  int? dia;
  String? status;
  DateTime? recordedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;

  Map<String, dynamic> toJson() => {
    'id': id,
    'idCard': idCard,
    'sys': sys,
    'dia': dia,
    'status': status,
    'recordedAt': recordedAt?.toIso8601String(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'userId': userId,
  };
  BloodProfileEntity toEntity() {
    return BloodProfileEntity(
      userId: userId!,
      idCard: idCard!,
      id: id!,
      sys: sys ?? 0,
      dia: dia ?? 0,
      status: status?.bloodPressureArabicLabel ?? 'غير معرفة',
      trafficColor: status!.bloodPressureTrafficColor,
    );
  }
}
