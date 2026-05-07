import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';

class CustomRowSelectTypeMedicine extends StatelessWidget {
  const CustomRowSelectTypeMedicine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.w,
      children: [
        Expanded(
          child: Container(
            padding: REdgeInsets.symmetric(vertical: 24, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.r),
              color: AppColor.primaryNormal,
            ),
            child: Column(
              children: [
                SvgPicture.asset(AppIcons.tablet),
                const RSizedBox(height: 8),
                Text('كبسولات', style: AppTextStyles.s16.w500.white),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: REdgeInsets.symmetric(vertical: 24, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.r),
              color: AppColor.white,
              boxShadow: const [
                BoxShadow(
                  color: AppColor.shadowColor,
                  blurRadius: 3,
                  offset: Offset(0, 0),
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Column(
              children: [
                SvgPicture.asset(AppIcons.injectionMedicine),
                const RSizedBox(height: 8),
                Text('حقن', style: AppTextStyles.s16.w500.black),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: REdgeInsets.symmetric(vertical: 24, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.r),
              color: AppColor.white,
              boxShadow: const [
                BoxShadow(
                  color: AppColor.shadowColor,
                  blurRadius: 3,
                  offset: Offset(0, 0),
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Column(
              children: [
                SvgPicture.asset(AppIcons.waterMedicine),
                const RSizedBox(height: 8),
                Text('شرب', style: AppTextStyles.s16.w500.black),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
