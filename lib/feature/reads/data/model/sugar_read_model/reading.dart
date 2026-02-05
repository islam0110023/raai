import 'package:raai/core/utils/constants.dart';
import 'package:raai/feature/reads/data/model/sugar_read_model/sugar_status.dart';
import 'package:raai/feature/reads/domain/entity/sugar_read_entity.dart';

class Reading {
  factory Reading.fromJson(Map<String, dynamic> json) => Reading(
    id: json['id'] as int?,
    idCard: json['idCard'] as String?,
    valueMgDl: json['valueMgDl'] as int?,
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
  );

  Reading({
    this.id,
    this.idCard,
    this.valueMgDl,
    this.status,
    this.recordedAt,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.isEditable,
  });
  int? id;
  String? idCard;
  int? valueMgDl;
  String? status;
  DateTime? recordedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  bool? isEditable;

  Map<String, dynamic> toJson() => {
    'id': id,
    'idCard': idCard,
    'valueMgDl': valueMgDl,
    'status': status,
    'recordedAt': recordedAt?.toIso8601String(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'userId': userId,
    'isEditable': isEditable,
  };
  SugarReadEntity toEntity() {
    return SugarReadEntity(
      id: id!,
      idCard: idCard!,
      valueMgDl: valueMgDl ?? 0,
      status: status?.toArabicSugarStatus ?? 'غير معرفة',
      recordedAt: AppConstant.formatRecordedAtLikeUI(recordedAt!.toString()),
      userId: userId!,
      isEditable: isEditable ?? false,
      trafficColor: status!.trafficColor,
    );
  }
}
