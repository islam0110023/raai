import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve:Curves.easeInOut,
        padding: REdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryNormal : Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: isSelected
                ? AppColor.primaryNormal
                : AppColor.subtextLightActive,
            width: 1.5.r,
          ),
        ),
        child: Row(
          spacing: 16.w,
          children: [
            Container(
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.grey,
                  width: 1.5.r,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 14.r, color: AppColor.primaryNormal)
                  : null,
            ),
            Expanded(
              child: Text(
                text,
                style: isSelected
                    ? AppTextStyles.s14.w400.white
                    : AppTextStyles.s14.w400.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
