import 'package:flutter/material.dart';
import 'package:raai/core/utils/app_color.dart';

enum HealthLevel { green, orange, red, none }

extension SugarStatusArabic on String {
  String get toArabicSugarStatus {
    switch (this) {
      case 'VERY_LOW':
        return 'منخفض جدًا';
      case 'LOW':
        return 'يحتاج متابعة';
      case 'NORMAL':
        return 'مطمئن';
      case 'HIGH':
        return 'يحتاج متابعة';
      case 'VERY_HIGH':
        return 'مرتفع جدًا';
      default:
        return 'غير معروف';
    }
  }

  Color get trafficColor {
    switch (this) {
      case 'VERY_LOW':
      case 'VERY_HIGH':
        return AppColor.redNormal;

      case 'LOW':
      case 'HIGH':
        return AppColor.orange;

      case 'NORMAL':
        return AppColor.greenNormal;

      default:
        return AppColor.orange;
    }
  }

  HealthLevel get level {
    switch (this) {
      case 'VERY_LOW':
      case 'VERY_HIGH':
        return HealthLevel.red;

      case 'LOW':
      case 'HIGH':
        return HealthLevel.orange;

      case 'NORMAL':
        return HealthLevel.green;

      default:
        return HealthLevel.orange;
    }
  }
}
