import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/pajamas.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';

class CustomBubbleChat extends StatelessWidget {
  const CustomBubbleChat({
    super.key,
    required this.message,
    this.isError = false,
    this.onTap,
  });
  final String message;
  final bool isError;
  final VoidCallback? onTap;

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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            decoration: BoxDecoration(
              color: AppColor.disableLightHover,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
                bottomLeft: Radius.circular(25.r),
              ),
            ),
            child: Text(
              message,
              style: AppTextStyles.s12.w600.textNormal,
              textAlign: TextAlign.right,
              softWrap: true,
            ),
          ),
        ),

        const RSizedBox(width: 4),
        Visibility(
          visible: isError,
          //replacement: ,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(45.r),
            splashColor: AppColor.primaryLightHover,
            highlightColor: AppColor.primaryLightHover,
            hoverColor: AppColor.primaryLightHover,
            radius: 100,
            child: Ink(
              width: 32.r,
              height: 32.r,
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
              child: Iconify(Pajamas.retry, size: 12.r),
            ),
          ),
        ),
      ],
    );
  }
}
