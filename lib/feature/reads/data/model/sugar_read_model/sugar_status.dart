import 'package:flutter/material.dart';
import 'package:raai/core/utils/app_color.dart';

extension SugarStatusArabic on String {
  String get toArabicSugarStatus {
    switch (this) {
      case 'VERY_LOW':
        return 'خطر جدًا';
      case 'LOW':
        return 'يحتاج متابعة';
      case 'NORMAL':
        return 'مطمئن';
      case 'HIGH':
        return 'يحتاج متابعة';
      case 'VERY_HIGH':
        return 'خطر جدًا';
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
}
