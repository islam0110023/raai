import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/medication/domain/entities/medication_data_entity.dart';

class CustomCardMedication extends StatelessWidget {
  const CustomCardMedication({super.key, required this.data});
  final MedicationDataEntity data;

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
              child: data.image == null
                  ? Image.asset(
                      AppImage.medicinePlaceholder,
                      fit: BoxFit.cover,
                      height: 128.h,
                      width: double.infinity,
                    )
                  : CachedNetworkImage(
                      imageUrl: data.image!,
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: AppColor.redNormal,
                        ),
                      ),
                      placeholder: (context, url) =>
                          // Theme.of(context).platform == TargetPlatform.iOS
                          // ? const Center(child: CupertinoActivityIndicator())
                          // : const Center(
                          //     child: CircularProgressIndicator(
                          //       color: AppColor.primaryNormal,
                          //     ),
                          //   ),
                          ShimmerEffect(width: double.infinity, height: 128.h),
                      height: 128.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const RSizedBox(height: 16),
          Row(
            children: [
              Text(data.name, style: AppTextStyles.s20.w600.textNormal),
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
                    SvgPicture.asset(
                      data.formIcon,
                      colorFilter: const ColorFilter.mode(
                        AppColor.primaryNormal,
                        BlendMode.srcIn,
                      ),
                    ),
                    const RSizedBox(width: 8),
                    Text(
                      data.form,
                      style: AppTextStyles.s16.w500.primaryNormal,
                    ),
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
                'الجرعة: ${data.pillsPerDose} وحدات',
                style: AppTextStyles.s14.w400.subTextNormal,
              ),
            ],
          ),
          const RSizedBox(height: 12),
          Row(
            children: [
              SvgPicture.asset(AppIcons.clock),
              const RSizedBox(width: 12),
              Text(
                '${data.dosesPerDayArabicLabel} في ${data.repeatType}',
                style: AppTextStyles.s14.w400.subTextNormal,
              ),
            ],
          ),
          const RSizedBox(height: 12),
          Row(
            children: [
              SvgPicture.asset(AppIcons.food),
              const RSizedBox(width: 12),
              Text(
                data.foodArabicLabel,
                style: AppTextStyles.s14.w400.subTextNormal,
              ),
            ],
          ),
          const RSizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('المخزون', style: AppTextStyles.s14.w400.disableNormalHover),
              Text(
                '${data.remainingPills}/${data.totalPills} ${data.form}',
                style: AppTextStyles.s14.w400.primaryNormal,
              ),
            ],
          ),
          const RSizedBox(height: 8),
          LinearProgressIndicator(
            value: data.remainingPills / data.totalPills,
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
