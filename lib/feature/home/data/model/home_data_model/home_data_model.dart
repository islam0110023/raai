import 'package:intl/intl.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/feature/home/data/model/home_data_model/caregiver.dart';
import 'package:raai/feature/home/data/model/home_data_model/last_readings.dart';
import 'package:raai/feature/home/data/model/home_data_model/next_medication.dart';
import 'package:raai/feature/home/domain/entities/home_data_entity.dart';
import 'package:raai/feature/profile/data/model/profile_user_model/ovarall_health.dart';

class HomeDataModel {
  HomeDataModel({
    this.lastReadings,
    this.caregiver,
    this.nextMedication,
    this.unreadAlerts,
    this.dailyStatus,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
    lastReadings: json['lastReadings'] == null
        ? null
        : LastReadings.fromJson(json['lastReadings'] as Map<String, dynamic>),
    caregiver: json['caregiver'] == null
        ? null
        : Caregiver.fromJson(json['caregiver'] as Map<String, dynamic>),
    nextMedication: json['nextMedication'] == null
        ? null
        : NextMedication.fromJson(
            json['nextMedication'] as Map<String, dynamic>,
          ),
    unreadAlerts: json['unreadAlerts'] as int?,
    dailyStatus: json['dailyStatus'] as String?,
  );
  LastReadings? lastReadings;
  Caregiver? caregiver;
  NextMedication? nextMedication;
  int? unreadAlerts;
  String? dailyStatus;

  Map<String, dynamic> toJson() => {
    'lastReadings': lastReadings?.toJson(),
    'caregiver': caregiver?.toJson(),
    'nextMedication': nextMedication?.toJson(),
    'unreadAlerts': unreadAlerts,
    'dailyStatus': dailyStatus,
  };

  HomeDataEntity toEntity() {
    return HomeDataEntity(
      status: (
        sugar: lastReadings?.sugar?.status,
        blood: lastReadings?.bloodPressure?.status,
      ).overallArabicLabel,
      trafficColor: (
        sugar: lastReadings?.sugar?.status,
        blood: lastReadings?.bloodPressure?.status,
      ).overallColor,
      trafficBackgroundColor: (
        sugar: lastReadings?.sugar?.status,
        blood: lastReadings?.bloodPressure?.status,
      ).overallBackgroundColor,
      medicationId: nextMedication?.id,
      medicationName: nextMedication?.name,
      medicationImage: nextMedication?.image,
      medicationTime: nextMedication?.time == null
          ? '--:--'
          : DateFormat(
              'hh:mm',
              'en',
            ).format(DateTime.parse(nextMedication!.time.toString()).toLocal()),
      medicationPeriod: nextMedication?.time == null
          ? ''
          : AppConstant.getArabicPeriod(
              DateTime.parse(nextMedication!.time.toString()).toLocal(),
            ),
      medicationTimeDifference: nextMedication?.time == null
          ? null
          : DateTime.parse(nextMedication!.time.toString()).toLocal(),
      caregiverName: caregiver?.name,
      caregiverId: caregiver?.id,
    );
  }
}
