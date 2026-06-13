import 'package:raai/feature/medication/domain/entities/medication_reminder_entity.dart';

class MedicationReminderModel {
  const MedicationReminderModel({
    this.id,
    this.name,
    this.image,
    this.form,
    this.doseId,
    this.pillsPerDose,
    this.withFood,
    this.foodTiming,
    this.scheduledTime,
  });

  factory MedicationReminderModel.fromJson(Map<String, dynamic> json) {
    return MedicationReminderModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      form: json['form'] as String?,
      doseId: json['doseId'] as int?,
      pillsPerDose: json['pillsPerDose'] as int?,
      withFood: json['withFood'] as bool?,
      foodTiming: json['foodTiming'] as String?,
      scheduledTime: json['scheduledTime'] != null
          ? DateTime.parse(json['scheduledTime'])
          : null,
    );
  }
  final int? id;
  final String? name;
  final String? image;
  final String? form;
  final int? doseId;
  final int? pillsPerDose;
  final bool? withFood;
  final String? foodTiming;
  final DateTime? scheduledTime;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'form': form,
      'doseId': doseId,
      'pillsPerDose': pillsPerDose,
      'withFood': withFood,
      'foodTiming': foodTiming,
      'scheduledTime': scheduledTime?.toIso8601String(),
    };
  }

  MedicationReminderEntity toEntity() {
    return MedicationReminderEntity(
      image: image,
      form: form,
      name: name ?? '',
      pillsPerDose: pillsPerDose ?? 0,
      withFood: withFood ?? false,
      foodTiming: foodTiming,
      scheduledTime: scheduledTime ?? DateTime.now(),
      doseId: doseId!,
      id: id!,
    );
  }

  // MedicationDoseModel copyWith({
  //   String? id,
  //   String? name,
  //   String? image,
  //   String? form,
  //   String? doseId,
  //   int? pillsPerDose,
  //   bool? withFood,
  //   String? foodTiming,
  //   DateTime? scheduledTime,
  // }) {
  //   return MedicationDoseModel(
  //     id: id ?? this.id,
  //     name: name ?? this.name,
  //     image: image ?? this.image,
  //     form: form ?? this.form,
  //     doseId: doseId ?? this.doseId,
  //     pillsPerDose: pillsPerDose ?? this.pillsPerDose,
  //     withFood: withFood ?? this.withFood,
  //     foodTiming: foodTiming ?? this.foodTiming,
  //     scheduledTime: scheduledTime ?? this.scheduledTime,
  //   );
  // }
}
