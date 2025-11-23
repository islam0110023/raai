import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class CustomContainerPersonalInfoUpper extends StatelessWidget {
  const CustomContainerPersonalInfoUpper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      maxWidth: 600,
      child: Container(
        width: double.infinity,
        height: 280.h,
        transform: Matrix4.identity()..translate(0.0, -310.0.h),
        decoration: const ShapeDecoration(
          shape: OvalBorder(),
          gradient: LinearGradient(
            colors: [AppColor.primaryNormal, AppColor.primaryLight],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        alignment: const Alignment(0, 0),
        child: Text(
          'البيانات الشخصيه',
          style: AppTextStyles.s24.w700.black,
        ),
      ),
    );
  }
}
