import 'package:flutter/material.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';

extension SugarMonthlyStatus on String {
  String get sugarMonthlyArabicLabel {
    switch (this) {
      case '0':
        return 'مطمئن';
      case '1':
        return 'خطر جدًا';

      default:
        return 'خطر جدًا';
    }
  }

  String get sugarMonthlyIconArabicLabel {
    switch (this) {
      case '0':
        return AppIcons.validationCheck;
      case '1':
        return AppIcons.errorCheck;

      default:
        return AppIcons.errorCheck;
    }
  }

  String get sugarMonthlyStatementArabicLabel {
    switch (this) {
      case '0':
        return '''استمر على نفس النظام الغذائي الصحي
تابع القياس بانتظام كما تفعل
لا تنسَ مواعيد الدواء إن وُجدت''';
      case '1':
        return '''يُفضّل إعادة القياس في وقت آخر من اليوم
انتبه للطعام والشراب اليوم
القراءة تحتاج متابعة
 يفضل تواصل مع الطبيب''';

      default:
        return '''يُفضّل إعادة القياس في وقت آخر من اليوم
انتبه للطعام والشراب اليوم
القراءة تحتاج متابعة
 يفضل تواصل مع الطبيب''';
    }
  }

  String get sugarMonthlyDesArabicLabel {
    switch (this) {
      case '0':
        return 'معدل السكر طبيعي و النسبه في النطاق الامن';
      case '1':
        return 'المعدل غير طبيعي و النسبه في النطاق الغير الامن';

      default:
        return 'المعدل غير طبيعي و النسبه في النطاق الغير الامن';
    }
  }

  Color get sugarMonthlyTrafficColor {
    switch (this) {
      case '0':
        return AppColor.greenNormalActive;
      case '1':
        return AppColor.redNormalActive;

      default:
        return AppColor.redNormalActive;
    }
  }

  Color get sugarMonthlyBackgroundTrafficColor {
    switch (this) {
      case '0':
        return AppColor.secondaryLight;
      case '1':
        return AppColor.redLight;

      default:
        return AppColor.redLight;
    }
  }
}
