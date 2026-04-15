import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';

class CustomCardRequestNotification extends StatelessWidget {
  const CustomCardRequestNotification({
    super.key,
    required this.title1,
    required this.title2,
    required this.subtitle,
    required this.date,
    this.onReject,
    this.onAccept,
  });
  final String title1;
  final String title2;
  final String subtitle;
  final String date;
  final VoidCallback? onReject;
  final VoidCallback? onAccept;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadowColor,
            offset: Offset(0, 0),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: SvgPicture.asset(AppIcons.personNot),
            title: Padding(
              padding: REdgeInsets.only(bottom: 10),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title1,
                      style: AppTextStyles.s14.w400.primaryNormal,
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: title2,
                      style: AppTextStyles.s14.w400.textNormal,
                    ),
                  ],
                ),
              ),
            ),
            subtitle: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: subtitle,
                    style: AppTextStyles.s12.w300.subTextNormal,
                  ),
                  TextSpan(
                    text: ' - ',
                    style: AppTextStyles.s12.w300.subTextNormal,
                  ),
                  TextSpan(
                    text: date,
                    style: AppTextStyles.s12.w300.subTextNormal,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              spacing: 15.w,
              children: [
                Expanded(
                  child: AppButton.outline(
                    text: 'رفض',
                    onPressed: onReject,
                    borderColor: AppColor.redDark,
                    textStyle: AppTextStyles.s14.w400.redDarker,
                    radius: 12,
                    borderWidth: 1.r,
                    isOutlineColor: false,
                    textColor: AppColor.redNormalHover,
                    padding: REdgeInsets.symmetric(vertical: 8),
                  ),
                ),
                Expanded(
                  child: AppButton.outline(
                    text: 'قبول',
                    onPressed: onAccept,
                    borderColor: AppColor.greenDarkHover,
                    textStyle: AppTextStyles.s14.w400.greenDarker,
                    radius: 12,
                    borderWidth: 1.r,
                    isOutlineColor: false,
                    textColor: AppColor.greenNormalHover,
                    padding: REdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
