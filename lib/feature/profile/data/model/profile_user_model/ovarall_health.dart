import 'package:flutter/cupertino.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/feature/reads/data/model/sugar_read_model/sugar_status.dart';

extension OverallHealthStatus on ({String? sugar, String? blood}) {
  HealthLevel get overallLevel {
    final sugarLevel = sugar?.level ?? HealthLevel.none;
    final bloodLevel = blood?.level ?? HealthLevel.none;

    if (sugarLevel == HealthLevel.none && bloodLevel == HealthLevel.none) {
      return HealthLevel.none;
    }

    if (sugarLevel == HealthLevel.red || bloodLevel == HealthLevel.red) {
      return HealthLevel.red;
    }

    if (sugarLevel == HealthLevel.orange || bloodLevel == HealthLevel.orange) {
      return HealthLevel.orange;
    }

    return HealthLevel.green;
  }

  String get overallArabicLabel {
    switch (overallLevel) {
      case HealthLevel.none:
        return 'لا توجد قراءات';
      case HealthLevel.green:
        return 'مطمئن';
      case HealthLevel.orange:
        return 'يحتاج متابعة';
      case HealthLevel.red:
        return 'خطر جدًا';
    }
  }

  Color get overallColor {
    switch (overallLevel) {
      case HealthLevel.none:
        return AppColor.disableNormalActive;
      case HealthLevel.green:
        return AppColor.secondaryNormalActive;
      case HealthLevel.orange:
        return AppColor.orangeNormalActive;
      case HealthLevel.red:
        return AppColor.redNormalActive;
    }
  }

  Color get overallBackgroundColor {
    switch (overallLevel) {
      case HealthLevel.none:
        return AppColor.disableLight;
      case HealthLevel.green:
        return AppColor.secondaryLight;
      case HealthLevel.orange:
        return AppColor.orangeLight;
      case HealthLevel.red:
        return AppColor.redLight;
    }
  }
}
