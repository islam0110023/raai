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
    this.isLabel = true,
  });
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final bool isLabel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(45.r),
      splashColor: AppColor.primaryLightHover,
      radius: 100.r,
      hoverColor: AppColor.primaryLightHover,
      child: Ink(
        padding: REdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColor.white,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppIcons.arrowBack),
            Visibility(
              visible: isLabel,
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 8),
                child: Text('عوده', style: AppTextStyles.s14.w400.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
