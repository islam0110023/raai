import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';

class CustomCardLastReadNoData extends StatelessWidget {
  const CustomCardLastReadNoData({super.key, required this.isBlood});
  final bool isBlood;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: AppColor.white,
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadowColor,
            blurRadius: 12,
            offset: Offset(0, 0),
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: isBlood,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppIcons.blood, width: 16.r, height: 16.r),
                const RSizedBox(width: 4),
                Text('اخر سكر', style: AppTextStyles.s14.w400.textNormal),
              ],
            ),
          ),
          Visibility(
            visible: !isBlood,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppIcons.heart, width: 16.r, height: 16.r),
                const RSizedBox(width: 4),
                Text('اخر ضغط', style: AppTextStyles.s14.w400.textNormal),
              ],
            ),
          ),
          const RSizedBox(height: 16),
          Text('لا يوجد قراءات', style: AppTextStyles.s16.w500.redNormalActive),
          const RSizedBox(height: 16),
        ],
      ),
    );
  }
}
