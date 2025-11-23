import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/widget/app_button_back.dart';

class CustomBackgroundAuth extends StatelessWidget {
  const CustomBackgroundAuth({
    super.key,
    required this.children,
    this.isBack = false,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });
  final List<Widget> children;
  final bool isBack;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            AppImage.imageAuth,
            width: double.infinity,
            height: 330.h,
            fit: BoxFit.cover,
          ),
        ),
        if (isBack)
          Positioned(
            top: 50.h,
            right: 16.w,

            child: AppButtonBack(
              onPressed: () {
                context.pop();
              },
              backgroundColor: AppColor.white.withAlpha(150),
            ),
          ),
        Positioned(
          top: 250.h,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            padding: REdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(36.r)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: crossAxisAlignment,
                children: children,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
