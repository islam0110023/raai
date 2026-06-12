import 'package:flutter/material.dart';
import 'package:raai/core/utils/app_color.dart';

extension HomeCaregiverStatus on String {
  Color get statusElderCaregiver {
    switch (this) {
      case 'NORMAL':
        return AppColor.greenNormal;
      case 'WARNING':
        return AppColor.orange;
      case 'CRITICAL':
        return AppColor.redNormal;
      default:
        return AppColor.greenNormal;
    }
  }
}
