import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';

class SwipeToDeleteWrapper extends StatelessWidget {
  const SwipeToDeleteWrapper({
    super.key,
    required this.child,
    required this.onDelete,
  });
  final Widget child;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        onDelete();
      },
      background: Container(color: Colors.transparent),
      secondaryBackground: Container(
        alignment: Alignment.centerLeft,
        padding: REdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: AppColor.redLightHover,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: SvgPicture.asset(AppIcons.rubbish),
      ),
      direction: DismissDirection.endToStart,
      child: child,
    );
  }
}
