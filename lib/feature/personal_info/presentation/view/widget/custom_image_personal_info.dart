import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:raai/core/utils/app_color.dart';

class CustomImagePersonalInfo extends StatelessWidget {
  const CustomImagePersonalInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 170.h,
      left: 10,
      right: 10,
      child: CircleAvatar(
        radius: 60,
        backgroundColor: AppColor.primaryLight,
        child: Align(
          alignment: const Alignment(.27, 1.28),
          child: Container(
            width: 46.r,
            height: 46.r,
            padding: REdgeInsets.all(5),
            decoration: ShapeDecoration(
              color: AppColor.subtextLightHover,
              shape: OvalBorder(
                side: BorderSide(width: 3.r, color: AppColor.disableLight),
              ),
            ),
            child: const Iconify(Bx.edit_alt),
          ),
        ),
      ),
    );
  }
}
