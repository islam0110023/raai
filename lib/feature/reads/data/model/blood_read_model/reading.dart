import 'package:raai/core/utils/constants.dart';
import 'package:raai/feature/reads/data/model/blood_read_model/blood_status.dart';
import 'package:raai/feature/reads/domain/entity/blood_read_entity.dart';

class Reading {
  factory Reading.fromJson(Map<String, dynamic> json) => Reading(
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
    isEditable: json['isEditable'] as bool?,
    statusCode: json['statusCode'] as int?,
  );

  Reading({
    this.id,
    this.idCard,
    this.sys,
    this.dia,
    this.status,
    this.recordedAt,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.isEditable,
    this.statusCode,
  });
  int? id;
  String? idCard;
  int? sys;
  int? dia;
  String? status;
  DateTime? recordedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  bool? isEditable;
  int? statusCode;

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
    'isEditable': isEditable,
    'statusCode': statusCode,
  };
  BloodReadEntity toEntity() {
    return BloodReadEntity(
      id: id!,
      idCard: idCard!,
      sys: sys ?? 0,
      dia: dia ?? 0,
      status: status?.bloodPressureArabicLabel ?? 'غير معرفة',
      recordedAt: AppConstant.formatRecordedAtLikeUI(recordedAt!.toString()),
      userId: userId!,
      isEditable: isEditable ?? false,
      statusCode: statusCode!,
      trafficColor: status!.bloodPressureTrafficColor,
      recordedAtDate: recordedAt!,
    );
  }
}
