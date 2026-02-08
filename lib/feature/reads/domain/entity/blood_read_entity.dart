import 'package:flutter/material.dart';

class BloodReadEntity {
  BloodReadEntity({
    required this.id,
    required this.idCard,
    required this.sys,
    required this.dia,
    required this.status,
    required this.recordedAt,
    required this.userId,
    required this.isEditable,
    required this.statusCode,
    required this.trafficColor,
    required this.recordedAtDate,
  });

  final int id;
  final String idCard;
  final int sys;
  final int dia;
  final String status;
  final String recordedAt;
  final DateTime recordedAtDate;
  final int userId;
  final bool isEditable;
  final int statusCode;
  final Color trafficColor;
}
