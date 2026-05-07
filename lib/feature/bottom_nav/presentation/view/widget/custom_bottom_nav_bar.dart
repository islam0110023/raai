import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/feature/bottom_nav/presentation/manager/bottom_nav_cubit.dart';
import 'package:raai/feature/bottom_nav/presentation/view/widget/bottom_nav_home_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.controller,
    required this.state,
  });

  final BottomNavCubit controller;
  final BottomNavCubit state;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      margin: REdgeInsets.fromLTRB(26, 0, 26, 48),
      padding: REdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColor.disableLightHover,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadowColor,
            spreadRadius: 5,
            blurRadius: 12,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(controller.items.length, (index) {
          return BottomNavItem(
            icon: controller.items[index]['icon'] as String,
            label: controller.items[index]['label'] as String,
            isActive: state.currentIndex == index,
            onTap: () {
              controller.changeIndex(index);
            },
          );
        }),
      ),
    );
  }
}
