import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class CustomCardNotification extends StatelessWidget {
  const CustomCardNotification({
    super.key,
    this.isRead = false,
    required this.icon,
    required this.title1,
    required this.title2,
    required this.subtitle,
    required this.date,
  });
  final bool isRead;
  final String icon;
  final String title1;
  final String title2;
  final String subtitle;
  final String date;

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
      child: ListTile(
        leading: isRead
            ? null
            : const CircleAvatar(
                radius: 5,
                backgroundColor: AppColor.secondaryNormal,
              ),
        title: Padding(
          padding: REdgeInsets.only(bottom: 5),
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
              TextSpan(text: date, style: AppTextStyles.s12.w300.subTextNormal),
            ],
          ),
        ),
        horizontalTitleGap: 0,
        minLeadingWidth: 18.w,
        trailing: SvgPicture.asset(icon),
      ),
    );
  }
}
