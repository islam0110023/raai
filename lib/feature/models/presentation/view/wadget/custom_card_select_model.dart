import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class CustomCardSelectModel extends StatelessWidget {
  const CustomCardSelectModel({
    super.key,
    this.onTap,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.color,
  });
  final VoidCallback? onTap;
  final String title;
  final String subtitle;
  final String icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: AppColor.white,
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadowColor,
            blurRadius: 12,
            offset: Offset(0, 0),
            spreadRadius: 3,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: REdgeInsets.symmetric(vertical: 12, horizontal: 16),
        onTap: onTap,
        leading: Icon(
          Icons.arrow_back_ios_new,
          color: AppColor.primaryNormal,
          size: 28.r,
        ),
        title: Text(title, style: AppTextStyles.s16.w500.textNormal),
        subtitle: Padding(
          padding: REdgeInsets.only(top: 8),
          child: Text(subtitle, style: AppTextStyles.s14.w400.subTextNormal),
        ),
        trailing: Container(
          padding: REdgeInsets.all(14),
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
            color: AppColor.primaryLightHover,
          ),
          child: SvgPicture.asset(
            icon,
            width: 28.r,
            height: 28.r,
            colorFilter: ColorFilter.mode(
              color ?? AppColor.redNormal,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
