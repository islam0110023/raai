import 'package:raai/core/utils/app_icons.dart';

extension MedicationStatusUi on String {
  String get medicationTypeArabicLabel {
    switch (this) {
      case 'TABLET':
        return 'كبسولة';
      case 'INJECTION':
        return 'حقن';
      case 'SYRUP':
        return 'شراب';
      default:
        return 'كبسولة';
    }
  }

  String get medicationTypeArabicIcon {
    switch (this) {
      case 'TABLET':
        return AppIcons.tabletMedicine;
      case 'INJECTION':
        return AppIcons.injection;
      case 'SYRUP':
        return AppIcons.syrupMedicine;
      default:
        return AppIcons.tabletMedicine;
    }
  }

  String get medicationRepeatTypeArabicLabel {
    switch (this) {
      case 'DAILY':
        return 'اليوم';
      case 'WEEKLY':
        return 'الاسبوع';
      default:
        return 'اليوم';
    }
  }
}

extension MedicationStatusUi2String on (bool, String) {
  String get medicationFoodArabicLabel {
    if (!this.$1) return 'ليس مرتبط';

    return this.$2 == 'AFTER' ? 'بعد الأكل' : 'قبل الأكل';
  }
}

extension MedicationStatusUiInt on int {
  String get medicationDosesPerDay {
    if (this == 1) {
      return 'مرة';
    }

    if (this == 2) {
      return 'مرتين';
    }

    if (this >= 3 && this <= 10) {
      return '$this مرات';
    }

    return '$this مرة';
  }
}
