import 'package:raai/feature/models/data/model/sugar_daily_model/meta.dart';
import 'package:raai/feature/models/data/model/sugar_daily_model/reading.dart';
import 'package:raai/feature/models/data/model/sugar_daily_model/sugar_daily_status.dart';
import 'package:raai/feature/models/domain/entity/sugar_daily_entity.dart';

class SugarDailyModel {
  SugarDailyModel({this.probability, this.meta, this.readings});

  factory SugarDailyModel.fromJson(Map<String, dynamic> json) {
    return SugarDailyModel(
      probability: (json['probability'] as num?)?.toDouble(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      readings: (json['readings'] as List<dynamic>?)
          ?.map((e) => Reading.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  double? probability;
  Meta? meta;
  List<Reading>? readings;

  Map<String, dynamic> toJson() => {
    'probability': probability,
    'meta': meta?.toJson(),
    'readings': readings?.map((e) => e.toJson()).toList(),
  };
  SugarDailyEntity toEntity() {
    return SugarDailyEntity(
      lastReadings: readings?.map((e) => e.toEntity()).toList() ?? [],
      probability: probability ?? 0,
      readingsUsedForAi: meta?.readingsUsedForAi ?? 0,
      status: probability?.sugarRiskArabicLabel ?? 'غير معرفة',
      trafficColor: probability!.sugarRiskTrafficColor,
      statement: probability!.sugarRiskStatementArabicLabel,
      description: probability!.sugarRiskDescriptionArabic,
      backgroundTrafficColor: probability!.sugarRiskBackgroundColor,
      prac: (probability! * 100).toInt(),
    );
  }
}
