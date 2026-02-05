import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });
  final String icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        padding: REdgeInsets.all(8),
        height: 40.h,
        decoration: BoxDecoration(
          color: isActive ? AppColor.primaryNormal : AppColor.disableLight,
          borderRadius: isActive
              ? BorderRadius.circular(24.r)
              : BorderRadius.circular(90),
          boxShadow: isActive
              ? const [
                  BoxShadow(
                    color: AppColor.secondaryNormalActive,
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: Offset(0, 0),
                  ),
                ]
              : const [
                  BoxShadow(
                    color: AppColor.shadowColor,
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: Offset(0, 0),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                isActive ? Colors.white : AppColor.disableDark,
                BlendMode.srcIn,
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    axis: Axis.horizontal,
                    child: child,
                  ),
                );
              },
              child: isActive
                  ? Padding(
                      key: const ValueKey('label'),
                      padding: REdgeInsets.only(right: 8),
                      child: Text(label, style: AppTextStyles.s16.w500.white),
                    )
                  : const SizedBox(key: ValueKey('empty')),
            ),
          ],
        ),
      ),
    );
  }
}
