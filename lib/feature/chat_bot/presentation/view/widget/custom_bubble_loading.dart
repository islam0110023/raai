import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/asset_image.dart';

class CustomBubbleLoading extends StatelessWidget {
  const CustomBubbleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          heightFactor: 0.0,
          child: Container(
            width: 38.r,
            height: 38.r,
            padding: REdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: AppColor.white,
              boxShadow: const [
                BoxShadow(
                  color: AppColor.shadowColor,
                  offset: Offset(0, 0),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.circular(45.r),
            ),
            child: SvgPicture.asset(AppIcons.chatBot),
          ),
        ),
        const RSizedBox(width: 1),

        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ScreenUtil.defaultSize.width * .75,
          ),
          child: Container(
            // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.disableLightHover,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
                bottomLeft: Radius.circular(25.r),
              ),
            ),
            child: Lottie.asset(
              AppImage.chatLoading,
              width: 90,
              height: 50,
              repeat: true,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
