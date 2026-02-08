import 'package:raai/core/utils/constants.dart';
import 'package:raai/feature/models/domain/entity/sugar_last_reading_entity.dart';
import 'package:raai/feature/reads/data/model/sugar_read_model/sugar_status.dart';

class LastReading {
  LastReading({this.idCard, this.valueMgDl, this.status, this.recordedAt});

  factory LastReading.fromJson(Map<String, dynamic> json) => LastReading(
    idCard: json['idCard'] as String?,
    valueMgDl: json['valueMgDl'] as int?,
    status: json['status'] as String?,
    recordedAt: json['recordedAt'] == null
        ? null
        : DateTime.parse(json['recordedAt'] as String),
  );
  String? idCard;
  int? valueMgDl;
  String? status;
  DateTime? recordedAt;

  Map<String, dynamic> toJson() => {
    'idCard': idCard,
    'valueMgDl': valueMgDl,
    'status': status,
    'recordedAt': recordedAt?.toIso8601String(),
  };
  SugarLastReadingEntity toEntity() {
    return SugarLastReadingEntity(
      idCard: idCard!,
      valueMgDl: valueMgDl ?? 0,
      month: AppConstant.formatSugarMonthAtLikeUI(recordedAt.toString()),
      status: status?.toArabicSugarStatus ?? 'غير معرفة',
      trafficColor: status!.trafficColor,
      time: AppConstant.formatSugarTimeAtLikeUI(recordedAt.toString()),
    );
  }
}
