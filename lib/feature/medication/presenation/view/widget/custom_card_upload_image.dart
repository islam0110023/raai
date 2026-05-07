import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';

class CustomCardUploadImage extends StatelessWidget {
  const CustomCardUploadImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: AppColor.disableNormalHover,
        strokeWidth: 2.r,
        dashPattern: const [7, 7],
        radius: const Radius.circular(32),
      ),
      child: Container(
        height: 192.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.addCamera),
            const RSizedBox(height: 16),
            Text(
              'إضافة صورة الدواء',
              style: AppTextStyles.s20.w600.subTextNormal,
            ),
          ],
        ),
      ),
    );
  }
}
