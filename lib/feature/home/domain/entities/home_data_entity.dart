import 'package:flutter/cupertino.dart';

class HomeDataEntity {
  HomeDataEntity({
    required this.status,
    required this.trafficColor,
    required this.trafficBackgroundColor,
    this.medicationId,
    this.medicationName,
    this.medicationImage,
    this.medicationTime,
    this.medicationPeriod,
    this.medicationTimeDifference,
    this.caregiverName,
    this.caregiverId,
    this.pillsPerDose,
    this.form,
    this.caregiverPhone,
  });

  final String status;
  final Color trafficColor;
  final Color trafficBackgroundColor;
  final int? medicationId;
  final String? medicationName;
  final String? medicationImage;
  final String? medicationTime;
  final String? medicationPeriod;
  final DateTime? medicationTimeDifference;
  final String? caregiverName;
  final int? caregiverId;
  final String? caregiverPhone;
  final int? pillsPerDose;
  final String? form;
}
