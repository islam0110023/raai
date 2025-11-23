import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class CustomAuthWithSocial extends StatelessWidget {
  const CustomAuthWithSocial({
    super.key,
    required this.name,
    required this.image,
  });
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(11),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.5.r, color: AppColor.borderColor),
          borderRadius: BorderRadius.circular(90),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Text(name, style: AppTextStyles.s16.w500.textNormal),
          Image.asset(image, width: 24.r),
        ],
      ),
    );
  }
}
