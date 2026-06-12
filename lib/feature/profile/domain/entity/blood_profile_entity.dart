import 'package:flutter/material.dart';

class BloodProfileEntity {
  BloodProfileEntity({
    required this.userId,
    required this.idCard,
    required this.id,
    required this.sys,
    required this.dia,
    required this.status,
    required this.trafficColor,
    required this.statusColor,
  });

  final int userId;
  final String idCard;
  final int id;
  final int sys;
  final int dia;
  final String status;
  final Color statusColor;
  final Color trafficColor;
}
