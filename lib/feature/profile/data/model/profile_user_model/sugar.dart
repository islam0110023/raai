import 'package:raai/feature/profile/domain/entity/sugar_profile_entity.dart';
import 'package:raai/feature/reads/data/model/sugar_read_model/sugar_status.dart';

class Sugar {
  Sugar({
    this.id,
    this.idCard,
    this.valueMgDl,
    this.status,
    this.recordedAt,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory Sugar.fromJson(Map<String, dynamic> json) => Sugar(
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
  );
  int? id;
  String? idCard;
  int? valueMgDl;
  String? status;
  DateTime? recordedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;

  Map<String, dynamic> toJson() => {
    'id': id,
    'idCard': idCard,
    'valueMgDl': valueMgDl,
    'status': status,
    'recordedAt': recordedAt?.toIso8601String(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'userId': userId,
  };
  SugarProfileEntity toEntity() {
    return SugarProfileEntity(
      id: id!,
      userId: userId!,
      idCard: idCard!,
      valueMgDl: valueMgDl ?? 0,
      status: status?.toArabicSugarStatus ?? 'غير معرفة',
      trafficColor: status!.trafficColor,
      statusColor: status!.statusColor,
    );
  }
}
