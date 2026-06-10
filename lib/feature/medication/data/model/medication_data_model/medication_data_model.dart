import 'package:raai/feature/medication/data/model/medication_data_model/medication.dart';
import 'package:raai/feature/medication/domain/entities/medication_data_entity.dart';

class MedicationDataModel {
  MedicationDataModel({
    this.page,
    this.limit,
    this.total,
    this.count,
    this.medications,
  });

  factory MedicationDataModel.fromJson(Map<String, dynamic> json) {
    return MedicationDataModel(
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      total: json['total'] as int?,
      count: json['count'] as int?,
      medications: (json['medications'] as List<dynamic>?)
          ?.map((e) => Medication.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  int? page;
  int? limit;
  int? total;
  int? count;
  List<Medication>? medications;

  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
    'total': total,
    'count': count,
    'medications': medications?.map((e) => e.toJson()).toList(),
  };
  List<MedicationDataEntity> toEntity() {
    return medications!.map((e) => e.toEntity()).toList();
  }
}
