import 'package:raai/feature/models/data/model/sugar_monthly_model/last_reading.dart';
import 'package:raai/feature/models/data/model/sugar_monthly_model/meta.dart';
import 'package:raai/feature/models/data/model/sugar_monthly_model/sugar_monthly_status.dart';
import 'package:raai/feature/models/domain/entity/sugar_monthly_entity.dart';

class SugarMonthlyModel {
  SugarMonthlyModel({this.prediction, this.meta, this.lastReadings});

  factory SugarMonthlyModel.fromJson(Map<String, dynamic> json) {
    return SugarMonthlyModel(
      prediction: json['prediction'] as int?,
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      lastReadings: (json['lastReadings'] as List<dynamic>?)
          ?.map((e) => LastReading.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  int? prediction;
  Meta? meta;
  List<LastReading>? lastReadings;

  Map<String, dynamic> toJson() => {
    'prediction': prediction,
    'meta': meta?.toJson(),
    'lastReadings': lastReadings?.map((e) => e.toJson()).toList(),
  };
  SugarMonthlyEntity toEntity() {
    return SugarMonthlyEntity(
      prediction: prediction ?? 0,
      lastReadings: lastReadings?.map((e) => e.toEntity()).toList() ?? [],
      readingsUsedForAi: meta?.readingsUsedForAi ?? 0,
      returnedReadings: meta?.returnedReadings ?? 0,
      status: prediction.toString().sugarMonthlyArabicLabel,
      description: prediction.toString().sugarMonthlyDesArabicLabel,
      trafficColor: prediction.toString().sugarMonthlyTrafficColor,
      backgroundTrafficColor: prediction
          .toString()
          .sugarMonthlyBackgroundTrafficColor,
      icon: prediction.toString().sugarMonthlyIconArabicLabel,
      statement: prediction.toString().sugarMonthlyStatementArabicLabel,
    );
  }
}
