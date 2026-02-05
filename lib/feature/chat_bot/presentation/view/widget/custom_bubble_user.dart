import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class CustomBubbleUser extends StatelessWidget {
  const CustomBubbleUser({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ScreenUtil.defaultSize.width * .90,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.5,
              vertical: 16.5,
            ),
            decoration: BoxDecoration(
              color: AppColor.primaryNormal,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.r),
                bottomLeft: Radius.circular(25.r),
                bottomRight: Radius.circular(25.r),
              ),
            ),
            child: Text(
              message,
              style: AppTextStyles.s12.w600.white,
              textAlign: TextAlign.right,
              softWrap: true,
            ),
          ),
        ),
      ],
    );
  }
}
