import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/feature/medication/data/model/medication_data_model/medication_status.dart';
import 'package:raai/feature/medication/data/model/medication_data_model/schedule.dart';
import 'package:raai/feature/medication/domain/entities/medication_data_entity.dart';

class Medication {
  Medication({
    this.id,
    this.name,
    this.category,
    this.image,
    this.form,
    this.elderId,
    this.isActive,
    this.createdAt,
    this.schedules,
    this.remainingPills,
    this.pillsPerDose,
    this.dosesPerDay,
    this.totalPills,
  });

  factory Medication.fromJson(Map<String, dynamic> json) => Medication(
    id: json['id'] as int?,
    name: json['name'] as String?,
    category: json['category'] as String?,
    image: json['image'] as String?,
    form: json['form'] as String?,
    elderId: json['elderId'] as int?,
    isActive: json['isActive'] as bool?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    schedules: (json['schedules'] as List<dynamic>?)
        ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
        .toList(),
    remainingPills: json['remainingPills'] as int?,
    pillsPerDose: json['pillsPerDose'] as int?,
    dosesPerDay: json['dosesPerDay'] as int?,
    totalPills: json['totalPills'] as int?,
  );
  int? id;
  String? name;
  String? category;
  String? image;
  String? form;
  int? elderId;
  bool? isActive;
  DateTime? createdAt;
  List<Schedule>? schedules;
  int? remainingPills;
  int? pillsPerDose;
  int? dosesPerDay;
  int? totalPills;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'image': image,
    'form': form,
    'elderId': elderId,
    'isActive': isActive,
    'createdAt': createdAt?.toIso8601String(),
    'schedules': schedules?.map((e) => e.toJson()).toList(),
    'remainingPills': remainingPills,
    'pillsPerDose': pillsPerDose,
    'dosesPerDay': dosesPerDay,
    'totalPills': totalPills,
  };
  MedicationDataEntity toEntity() {
    return MedicationDataEntity(
      id: id!,
      name: name!,
      category: category!,
      image: image,
      form:
          form?.medicationTypeArabicLabel ?? 'TABLET'.medicationTypeArabicLabel,
      elderId: elderId!,
      isActive: isActive!,
      remainingPills: remainingPills!,
      pillsPerDose: pillsPerDose!,
      dosesPerDay: dosesPerDay!,
      withFood: schedules![0].withFood!,
      foodTiming: schedules![0].foodTiming,
      totalPills: totalPills!,
      formIcon: form?.medicationTypeArabicIcon ?? AppIcons.tabletMedicine,
      dosesPerDayArabicLabel: dosesPerDay!.medicationDosesPerDay,
      repeatType: schedules![0].repeatType!.medicationRepeatTypeArabicLabel,
      foodArabicLabel: (
        schedules![0].withFood!,
        schedules![0].foodTiming ?? '',
      ).medicationFoodArabicLabel,
    );
  }
}
