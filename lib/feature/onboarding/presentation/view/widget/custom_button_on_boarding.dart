import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';

class CustomButtonOnBoarding extends StatelessWidget {
  const CustomButtonOnBoarding({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColor.primaryNormal,
        fixedSize: const Size(double.maxFinite, double.nan),
        padding: REdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45.r),
          side: BorderSide(width: 3.r, color: AppColor.secondaryLightHover),
        ),
      ),
      icon: Text('التالي', style: AppTextStyles.s16.w700.white),
      label: Padding(
        padding: REdgeInsets.symmetric(horizontal: 8),
        child: SvgPicture.asset(AppIcons.doubleArrowLeft),
      ),
    );
  }
}
