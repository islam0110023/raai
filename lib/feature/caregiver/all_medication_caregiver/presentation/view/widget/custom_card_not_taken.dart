import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/entity/all_doses_all_medication_caregiver.dart';

class CustomCardNotTaken extends StatelessWidget {
  const CustomCardNotTaken({super.key, required this.dose});
  final AllDosesAllMedicationCaregiver dose;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: REdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: AppColor.redLightHover, width: 2.r),
            boxShadow: const [
              BoxShadow(
                color: AppColor.shadowColor,
                blurRadius: 12,
                offset: Offset(0, 0),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                leading: Image.asset(AppImage.avatarMale),
                contentPadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dose.name, style: AppTextStyles.s16.w500.textNormal),
                    Container(
                      padding: REdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: ShapeDecoration(
                        color: AppColor.redLightHover,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                      child: Text(
                        'لم يتم الأخذ',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.s12.w300.redDarkHover,
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  spacing: 4.w,
                  children: [
                    Icon(
                      CupertinoIcons.clock,
                      color: AppColor.redDarkHover,
                      size: 16.r,
                    ),
                    Text(
                      '${AppConstant.formatTime1(dose.scheduledTime)} ${AppConstant.getArabicPeriod(dose.scheduledTime)}',
                      style: AppTextStyles.s14.w400.redDarkHover,
                    ),
                  ],
                ),
              ),
              const RSizedBox(height: 16),
              Container(
                padding: REdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.subtextLight,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border(
                    right: BorderSide(color: AppColor.redDarkHover, width: 6.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dose.medicationName,
                      style: AppTextStyles.s16.w500.redDarkHover,
                    ),
                    const Icon(
                      Icons.timer_off_outlined,
                      color: AppColor.redDarkHover,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Positioned(
          right: 2,
          top: 4,
          bottom: 4,
          child: Container(
            width: 10,
            decoration: const BoxDecoration(
              color: AppColor.redDarkActive,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
