import 'package:raai/feature/models/domain/entity/sugar_last_reading_entity.dart';
import 'package:flutter/material.dart';

class SugarDailyEntity {
  SugarDailyEntity({
    required this.lastReadings,
    required this.probability,
    required this.readingsUsedForAi,
    required this.status,
    required this.description,
    required this.trafficColor,
    required this.backgroundTrafficColor,
    required this.prac,
    required this.statement,
  });

  final List<SugarLastReadingEntity> lastReadings;
  final double probability;
  final int readingsUsedForAi;
  final String status;
  final String description;
  final Color trafficColor;
  final Color backgroundTrafficColor;
  final int prac;
  final String statement;
}
