import 'package:flutter/material.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/feature/reads/data/model/sugar_read_model/sugar_status.dart';

extension BloodPressureStatusUI on String {
  String get bloodPressureArabicLabel {
    switch (this) {
      case 'NORMAL':
        return 'مطمئن';

      case 'LOW':
      case 'HIGH':
        return 'يحتاج متابعة';

      case 'VERY_LOW':
        return 'منخفض جدًا';
      case 'VERY_HIGH':
        return 'مرتفع جدًا';
      case 'CRISIS':
        return 'خطر جدًا';

      default:
        return 'يحتاج متابعة';
    }
  }

  Color get bloodPressureTrafficColor {
    switch (this) {
      case 'NORMAL':
        return AppColor.greenNormal;

      case 'LOW':
      case 'HIGH':
        return AppColor.orange;

      case 'VERY_LOW':
      case 'VERY_HIGH':
      case 'CRISIS':
        return AppColor.redNormal;

      default:
        return AppColor.orange;
    }
  }

  HealthLevel get level {
    switch (this) {
      case 'NORMAL':
        return HealthLevel.green;

      case 'LOW':
      case 'HIGH':
        return HealthLevel.orange;

      case 'VERY_LOW':
      case 'VERY_HIGH':
      case 'CRISIS':
        return HealthLevel.red;

      default:
        return HealthLevel.orange;
    }
  }
}
