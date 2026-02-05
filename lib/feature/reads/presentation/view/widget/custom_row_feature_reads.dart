import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/reads/presentation/view/widget/custom_tab_bar_reads.dart';

class CustomRowFeatureReads extends StatefulWidget {
  const CustomRowFeatureReads({super.key, required this.tabController});
  final TabController tabController;

  @override
  State<CustomRowFeatureReads> createState() => _CustomRowFeatureReadsState();
}

class _CustomRowFeatureReadsState extends State<CustomRowFeatureReads> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RSizedBox(
          height: 45,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: Container(
              padding: isExpanded
                  ? REdgeInsets.fromLTRB(0, 4, 16, 4)
                  : REdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45.r),
                border: Border.all(color: AppColor.primaryNormal, width: 3.r),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    borderRadius: BorderRadius.circular(45.r),
                    radius: 10.r,
                    hoverColor: AppColor.secondaryLightHover,
                    child: SvgPicture.asset(
                      isExpanded ? AppIcons.filterLeft : AppIcons.filterRight,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
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
                    child: isExpanded
                        ? CustomTabBarReads(tabController: widget.tabController)
                        : const SizedBox(key: ValueKey('empty')),
                  ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            context.push(
              AppRoutes.addReads,
              extra: widget.tabController.index == 0 ? true : false,
            );
          },
          borderRadius: BorderRadius.circular(45.r),
          radius: 100.r,
          splashColor: AppColor.secondaryLightHover,
          child: Container(
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45.r),
              border: Border.all(color: AppColor.primaryNormal, width: 3.r),
            ),
            child: Row(
              children: [
                Text('جديد', style: AppTextStyles.s16.w500.textNormal),
                const RSizedBox(width: 4),
                SvgPicture.asset(AppIcons.plusSquare),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
