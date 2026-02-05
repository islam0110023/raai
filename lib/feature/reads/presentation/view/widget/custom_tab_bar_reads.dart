import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class CustomTabBarReads extends StatelessWidget {
  const CustomTabBarReads({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(right: 16.r),
      child: RSizedBox(
        width: 160,
        child: TabBar(
          tabs: const [Text('سكر'), Text('ضغط')],
          controller: tabController,
          dividerColor: Colors.transparent,
          labelStyle: AppTextStyles.s16.w500.white,
          unselectedLabelStyle: AppTextStyles.s16.w500.textNormal,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(45.r),
            color: AppColor.secondaryNormal,
            border: Border.all(color: AppColor.disableLightHover, width: 1.r),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: REdgeInsets.symmetric(horizontal: 5),
          splashBorderRadius: BorderRadius.circular(45.r),
          overlayColor: const WidgetStateColor.fromMap({
            WidgetState.pressed: AppColor.secondaryLightHover,
          }),
          labelPadding: REdgeInsets.fromLTRB(0, 4, 0, 4),
        ),
      ),
    );
  }
}
