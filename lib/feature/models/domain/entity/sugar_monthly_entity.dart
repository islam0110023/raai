import 'package:raai/feature/models/domain/entity/sugar_last_reading_entity.dart';
import 'package:flutter/material.dart';

class SugarMonthlyEntity {
  SugarMonthlyEntity({
    required this.prediction,
    required this.readingsUsedForAi,
    required this.returnedReadings,
    required this.lastReadings,
    required this.status,
    required this.description,
    required this.trafficColor,
    required this.backgroundTrafficColor,
    required this.icon,
    required this.statement,
  });

  final int prediction;
  final int readingsUsedForAi;
  final int returnedReadings;
  final String status;
  final String description;
  final Color trafficColor;
  final Color backgroundTrafficColor;
  final String icon;
  final String statement;
  final List<SugarLastReadingEntity> lastReadings;
}
