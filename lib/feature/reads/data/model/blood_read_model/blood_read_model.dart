import 'package:raai/feature/reads/data/model/blood_read_model/reading.dart';
import 'package:raai/feature/reads/domain/entity/blood_read_entity.dart';

class BloodReadModel {
  BloodReadModel({this.total, this.readings});

  factory BloodReadModel.fromJson(Map<String, dynamic> json) {
    return BloodReadModel(
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
  List<BloodReadEntity> toEntity() {
    return readings!.map((e) => e.toEntity()).toList();
  }
}
