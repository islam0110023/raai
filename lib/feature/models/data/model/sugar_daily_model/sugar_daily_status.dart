import 'package:flutter/material.dart';
import 'package:raai/core/utils/app_color.dart';

enum SugarRiskLevel { veryLow, lowModerate, moderateHigh, critical }

extension SugarMonthlyStatus on double {
  SugarRiskLevel get sugarRiskLevel {
    if (this < 0.30) {
      return SugarRiskLevel.veryLow;
    } else if (this >= 0.30 && this < 0.60) {
      return SugarRiskLevel.lowModerate;
    } else if (this >= 0.60 && this < 0.80) {
      return SugarRiskLevel.moderateHigh;
    } else {
      return SugarRiskLevel.critical;
    }
  }

  String get sugarRiskArabicLabel {
    switch (sugarRiskLevel) {
      case SugarRiskLevel.veryLow:
        return 'مطمئن';
      case SugarRiskLevel.lowModerate:
        return 'يحتاج متابعة';
      case SugarRiskLevel.moderateHigh:
        return 'خطر';
      case SugarRiskLevel.critical:
        return 'يجب زيارة طبيب';
    }
  }

  String get sugarRiskStatementArabicLabel {
    if (this < 0.30) {
      return '''استمر على نفس النظام الغذائي الصحي
تابع القياس بانتظام كما تفعل
حافظ على شرب الماء والنوم الجيد''';
    } else if (this >= 0.30 && this < 0.60) {
      return '''انتبه للطعام والشراب خلال اليوم
حاول تقليل السكريات والوجبات الثقيلة
تابع القياس مرة أخرى خلال نفس اليوم''';
    } else if (this >= 0.60 && this < 0.80) {
      return '''يُفضّل إعادة القياس بعد فترة قصيرة
قلّل السكريات فورًا خلال اليوم
إذا تكررت القراءات المرتفعة يُفضّل المتابعة الطبية''';
    } else {
      return '''القراءة مرتفعة جدًا وتحتاج متابعة عاجلة
يُفضّل إعادة القياس فورًا للتأكد
إذا استمرت النتيجة يُنصح بالتواصل مع الطبيب''';
    }
  }

  String get sugarRiskDescriptionArabic {
    switch (sugarRiskLevel) {
      case SugarRiskLevel.veryLow:
        return 'معدل السكر طبيعي والنسبة في النطاق الآمن';
      case SugarRiskLevel.lowModerate:
        return 'النسبة منخفضة إلى متوسطة وتحتاج متابعة بسيطة';
      case SugarRiskLevel.moderateHigh:
        return 'النسبة مرتفعة نسبيًا ويُفضّل الانتباه للمتابعة';
      case SugarRiskLevel.critical:
        return 'النسبة مرتفعة جدًا ويُفضّل التواصل مع الطبيب';
    }
  }

  Color get sugarRiskTrafficColor {
    switch (sugarRiskLevel) {
      case SugarRiskLevel.veryLow:
        return AppColor.greenNormalActive;
      case SugarRiskLevel.lowModerate:
        return AppColor.yellowNormalActive;
      case SugarRiskLevel.moderateHigh:
        return AppColor.orangeNormalActive;
      case SugarRiskLevel.critical:
        return AppColor.redNormalActive;
    }
  }

  Color get sugarRiskBackgroundColor {
    switch (sugarRiskLevel) {
      case SugarRiskLevel.veryLow:
        return AppColor.secondaryLight;
      case SugarRiskLevel.lowModerate:
        return AppColor.yellowLight;
      case SugarRiskLevel.moderateHigh:
        return AppColor.orangeLight;
      case SugarRiskLevel.critical:
        return AppColor.redLight;
    }
  }
}
