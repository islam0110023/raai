import 'package:raai/feature/medication/domain/entities/do_not_remember_entity.dart';

class DoNotRememberModel {

  DoNotRememberModel({
    this.medicationId,
    this.medicationName,
    this.expectedRemainingPills,
    this.actualRemainingPills,
    this.pillsPerDose,
    this.difference,
    this.missedDoses,
    this.status,
    this.message,
  });

  factory DoNotRememberModel.fromJson(Map<String, dynamic> json) {
    return DoNotRememberModel(
      medicationId: json['medicationId'] as int?,
      medicationName: json['medicationName'] as String?,
      expectedRemainingPills: json['expectedRemainingPills'] as int?,
      actualRemainingPills: json['actualRemainingPills'] as int?,
      pillsPerDose: json['pillsPerDose'] as int?,
      difference: json['difference'] as int?,
      missedDoses: json['missedDoses'] as int?,
      status: json['status'] as String?,
      message: json['message'] as String?,
    );
  }
  int? medicationId;
  String? medicationName;
  int? expectedRemainingPills;
  int? actualRemainingPills;
  int? pillsPerDose;
  int? difference;
  int? missedDoses;
  String? status;
  String? message;

  Map<String, dynamic> toJson() => {
    'medicationId': medicationId,
    'medicationName': medicationName,
    'expectedRemainingPills': expectedRemainingPills,
    'actualRemainingPills': actualRemainingPills,
    'pillsPerDose': pillsPerDose,
    'difference': difference,
    'missedDoses': missedDoses,
    'status': status,
    'message': message,
  };
  DoNotRememberEntity toEntity() {
    return DoNotRememberEntity(
      status: status!,
    );
  }
}
