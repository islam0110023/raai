import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class CustomSelectRole extends StatelessWidget {
  const CustomSelectRole({
    super.key,
    this.onChanged,
    required this.value,
    required this.title,
    required this.image,
    this.onTap,
  });
  final void Function(bool? value)? onChanged;
  final VoidCallback? onTap;
  final bool value;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16.h,
        children: [
          Image.asset(image, height: 318.h),
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: AppColor.primaryNormal,
              checkColor: AppColor.white,
              side: BorderSide(color: AppColor.disableNormal, width: 1.r),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(180),
              ),
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.s20.w600.black,
          ),
        ],
      ),
    );
  }
}
