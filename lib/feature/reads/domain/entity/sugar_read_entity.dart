import 'package:flutter/material.dart';

class SugarReadEntity {
  SugarReadEntity({
    required this.id,
    required this.idCard,
    required this.valueMgDl,
    required this.status,
    required this.recordedAt,
    required this.userId,
    required this.isEditable,
    required this.trafficColor,
    required this.recordedAtDate,
  });

  final int id;
  final String idCard;
  final int valueMgDl;
  final String status;
  final String recordedAt;
  final DateTime recordedAtDate;
  final int userId;
  final bool isEditable;
  final Color trafficColor;
}
