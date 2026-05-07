import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class CustomStatusHomeView extends StatelessWidget {
  const CustomStatusHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColor.secondaryLightHover,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(backgroundColor: AppColor.greenNormal, radius: 8.r),
            const RSizedBox(width: 8),
            Text('حالتك اليوم:', style: AppTextStyles.s16.w500.subTextNormal),
            const RSizedBox(width: 4),
            Text('مطمئن', style: AppTextStyles.s16.w500.greenNormal),
            const RSizedBox(width: 50),
          ],
        ),
      ),
    );
  }
}
