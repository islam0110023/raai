import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';

class AppButtonBack extends StatelessWidget {
  const AppButtonBack({
    super.key,
    required this.onPressed,
    this.backgroundColor,
  });
  final VoidCallback onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadowColor,
            offset: Offset(0, 0),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(45.r),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45.r),
          ),
          padding: REdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 0,
        ),
        label: Text('عوده', style: AppTextStyles.s14.w400.black),
        icon: SvgPicture.asset(AppIcons.arrowBack),
      ),
    );
  }
}
