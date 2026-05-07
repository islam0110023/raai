import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';

class CustomCardMedication extends StatelessWidget {
  const CustomCardMedication({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadowColor,
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 1,
          ),
        ],
      ),
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 1.1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: Image.asset(
                AppImage.imageAuth,
                height: 128.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const RSizedBox(height: 16),
          Row(
            children: [
              Text('أملوديبين', style: AppTextStyles.s20.w600.textNormal),
              const RSizedBox(width: 8),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(180),
                  border: BoxBorder.all(
                    color: AppColor.greenDarkHover,
                    width: 1.r,
                  ),
                ),
                padding: REdgeInsets.fromLTRB(7, 5, 3, 5),
                child: const Icon(
                  CupertinoIcons.play,
                  color: AppColor.greenDarkHover,
                  size: 16,
                ),
              ),
              const Spacer(),

              Container(
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(180),
                  color: AppColor.primaryLightHover,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.injection),
                    const RSizedBox(width: 8),
                    Text('حقن', style: AppTextStyles.s16.w500.primaryNormal),
                  ],
                ),
              ),
            ],
          ),
          const RSizedBox(height: 8),
          Row(
            children: [
              SvgPicture.asset(AppIcons.bagPlus),
              const RSizedBox(width: 12),
              Text(
                'الجرعة: 10 وحدات',
                style: AppTextStyles.s14.w400.subTextNormal,
              ),
            ],
          ),
          const RSizedBox(height: 12),
          Row(
            children: [
              SvgPicture.asset(AppIcons.clock),
              const RSizedBox(width: 12),
              Text('مره في اليوم', style: AppTextStyles.s14.w400.subTextNormal),
            ],
          ),
          const RSizedBox(height: 12),
          Row(
            children: [
              SvgPicture.asset(AppIcons.food),
              const RSizedBox(width: 12),
              Text('قبل الأكل', style: AppTextStyles.s14.w400.subTextNormal),
            ],
          ),
          const RSizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('المخزون', style: AppTextStyles.s14.w400.disableNormalHover),
              Text('2/5 حقن', style: AppTextStyles.s14.w400.primaryNormal),
            ],
          ),
          const RSizedBox(height: 8),
          LinearProgressIndicator(
            value: 2 / 5,
            borderRadius: BorderRadiusGeometry.circular(180),
            color: AppColor.primaryNormalHover,
            backgroundColor: AppColor.primaryLight,
            minHeight: 12.h,
          ),
          const RSizedBox(height: 16),
        ],
      ),
    );
  }
}
