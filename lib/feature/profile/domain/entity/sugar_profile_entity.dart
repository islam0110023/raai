import 'package:flutter/material.dart';

class SugarProfileEntity {
  SugarProfileEntity({
    required this.id,
    required this.userId,
    required this.idCard,
    required this.valueMgDl,
    required this.status,
    required this.trafficColor,
  });

  final int id;
  final int userId;
  final String idCard;
  final int valueMgDl;
  final String status;
  final Color trafficColor;
}
