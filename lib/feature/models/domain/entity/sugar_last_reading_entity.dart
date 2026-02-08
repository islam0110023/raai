import 'package:flutter/widgets.dart';

class SugarLastReadingEntity {
  SugarLastReadingEntity({
    required this.idCard,
    required this.valueMgDl,
    required this.status,
    required this.trafficColor,
    required this.time,
    required this.month,
  });

  final String idCard;
  final int valueMgDl;
  final String status;
  final String time;
  final String month;
  final Color trafficColor;
}
