import 'package:raai/feature/reads/data/model/sugar_read_model/reading.dart';
import 'package:raai/feature/reads/domain/entity/sugar_read_entity.dart';

class SugarReadModel {
  SugarReadModel({this.total, this.readings});

  factory SugarReadModel.fromJson(Map<String, dynamic> json) {
    return SugarReadModel(
      total: json['total'] as int?,
      readings: (json['readings'] as List<dynamic>?)
          ?.map((e) => Reading.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  int? total;
  List<Reading>? readings;

  Map<String, dynamic> toJson() => {
    'total': total,
    'readings': readings?.map((e) => e.toJson()).toList(),
  };
  List<SugarReadEntity> toEntity() {
    return readings!.map((e) => e.toEntity()).toList();
  }
}
