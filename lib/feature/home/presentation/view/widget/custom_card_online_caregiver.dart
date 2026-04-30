import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';

class CustomCardOnlineCaregiver extends StatelessWidget {
  const CustomCardOnlineCaregiver({super.key});

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
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 5.r,
              backgroundColor: AppColor.secondaryNormal,
            ),
            const RSizedBox(width: 10),
            Image.asset(AppImage.avatarMale, width: 48.r, height: 48.r),
          ],
        ),
        title: Padding(
          padding: REdgeInsets.only(bottom: 5),
          child: Text(
            'شعبان عبد الرحيم',
            style: AppTextStyles.s14.w400.primaryNormal,
          ),
        ),
        subtitle: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'مرافق رئيسي',
                style: AppTextStyles.s12.w300.subTextNormal,
              ),
              TextSpan(
                text: ' - ',
                style: AppTextStyles.s12.w300.subTextNormal,
              ),
              TextSpan(
                text: 'متصل',
                style: AppTextStyles.s12.w300.subTextNormal,
              ),
            ],
          ),
        ),
        trailing: AppButton.filled(
          text: 'الاتصال',
          onPressed: () {},
          width: 70.h,
          isOutlineColor: false,
          textStyle: AppTextStyles.s12.w300.secondaryLightHover,
          padding: REdgeInsets.all(8),
        ),
        contentPadding: REdgeInsets.only(top: 0, bottom: 0, left: 4, right: 10),
      ),
    );
  }
}
