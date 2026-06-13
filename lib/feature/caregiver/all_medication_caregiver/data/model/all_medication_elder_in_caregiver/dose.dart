import 'package:raai/feature/caregiver/all_medication_caregiver/domain/entity/all_doses_all_medication_caregiver.dart';

import 'elder.dart';
import 'medication.dart';
import 'status.dart';

class Dose {
  int? doseId;
  Elder? elder;
  Medication? medication;
  DateTime? scheduledTime;
  dynamic nextReminderTime;
  bool? taken;
  dynamic takenAt;
  Status? status;

  Dose({
    this.doseId,
    this.elder,
    this.medication,
    this.scheduledTime,
    this.nextReminderTime,
    this.taken,
    this.takenAt,
    this.status,
  });

  factory Dose.fromJson(Map<String, dynamic> json) => Dose(
    doseId: json['doseId'] as int?,
    elder: json['elder'] == null
        ? null
        : Elder.fromJson(json['elder'] as Map<String, dynamic>),
    medication: json['medication'] == null
        ? null
        : Medication.fromJson(json['medication'] as Map<String, dynamic>),
    scheduledTime: json['scheduledTime'] == null
        ? null
        : DateTime.parse(json['scheduledTime'] as String),
    nextReminderTime: json['nextReminderTime'] as dynamic,
    taken: json['taken'] as bool?,
    takenAt: json['takenAt'] as dynamic,
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'doseId': doseId,
    'elder': elder?.toJson(),
    'medication': medication?.toJson(),
    'scheduledTime': scheduledTime?.toIso8601String(),
    'nextReminderTime': nextReminderTime,
    'taken': taken,
    'takenAt': takenAt,
    'status': status?.toJson(),
  };
  AllDosesAllMedicationCaregiver toEntity() {
    return AllDosesAllMedicationCaregiver(
      doseId: doseId ?? 0,
      elderId: elder?.id ?? 0,
      name: elder?.name ?? '',
      medicationId: medication?.id ?? 0,
      medicationName: medication?.name ?? '',
      canSendReminder: status?.canSendReminder ?? false,
      isTaken: taken ?? false,
      medicationImage: medication?.image ?? '',
      medicationType: medication?.form ?? '',
      nextReminderTime: nextReminderTime ?? DateTime.now(),
      scheduledTime: scheduledTime ?? DateTime.now(),
      statusCode: status?.code ?? '',
    );
  }
}
