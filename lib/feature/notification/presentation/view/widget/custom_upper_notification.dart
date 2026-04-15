import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button_back.dart';

class CustomUpperNotification extends StatelessWidget {
  const CustomUpperNotification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: OverflowBox(
        maxWidth: 900,
        child: Container(
          width: double.infinity,
          height: 280.h,
          transform: Matrix4.identity()..translate(0.0, -430.0.h),
          decoration: const ShapeDecoration(
            shape: OvalBorder(),
            gradient: LinearGradient(
              colors: [AppColor.primaryLightActive, AppColor.primaryLight],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0, .3],
            ),
          ),
          alignment: const Alignment(0, .8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButtonBack(
                isLabel: false,
                isAuth: true,
                onPressed: () {
                  context.pop();
                },
              ),
              const RSizedBox(width: 80),

              Text('الإشعارات', style: AppTextStyles.s24.w700.black),
              const RSizedBox(width: 120),
            ],
          ),
        ),
      ),
    );
  }
}
