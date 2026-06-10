import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class CustomCardMedicineType extends StatelessWidget {
  const CustomCardMedicineType({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 24, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
          color: isSelected ? AppColor.primaryNormal : AppColor.white,
          boxShadow: isSelected
              ? null
              : const [
                  BoxShadow(
                    color: AppColor.shadowColor,
                    blurRadius: 3,
                    spreadRadius: 2,
                  ),
                ],
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColor.white : AppColor.black,
                BlendMode.srcIn,
              ),
            ),
            const RSizedBox(height: 8),
            Text(
              title,
              style: isSelected
                  ? AppTextStyles.s16.w500.white
                  : AppTextStyles.s16.w500.black,
            ),
          ],
        ),
      ),
    );
  }
}
