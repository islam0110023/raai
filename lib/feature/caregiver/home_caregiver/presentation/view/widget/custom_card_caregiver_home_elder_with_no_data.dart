import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/entity/home_caregiver_elder_data_entity.dart';

class CustomCardCaregiverHomeElderWithNoData extends StatelessWidget {
  const CustomCardCaregiverHomeElderWithNoData({super.key, required this.data});
  final HomeCaregiverElderDataEntity data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(24.r),
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
        children: [
          Row(
            children: [
              Image.asset(
                data.gender == 'MALE'
                    ? AppImage.avatarMale
                    : AppImage.avatarFemale,
                width: 64.r,
                height: 64.r,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(AppImage.avatarFemale);
                },
              ),
              const RSizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      textBaseline: TextBaseline.ideographic,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Expanded(
                          child: Text(
                            data.name,
                            style: AppTextStyles.s16.w500.textNormal,
                          ),
                        ),
                        const RSizedBox(width: 8),
                        Text(
                          data.status.label,
                          style: AppTextStyles.s12.w300.greenNormal.copyWith(
                            color: data.status.trafficColor,
                          ),
                        ),
                        const RSizedBox(width: 4),
                        CircleAvatar(
                          backgroundColor: data.status.trafficColor,
                          radius: 6.r,
                        ),
                      ],
                    ),
                    Text(
                      '${data.age} عاماً',
                      style: AppTextStyles.s14.w400.textNormal,
                    ),
                    Text(
                      AppConstant.getLastSeen(data.lastActivity),
                      style: AppTextStyles.s12.w300.subTextNormal,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const RSizedBox(height: 8),
          Container(
            padding: REdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.brownLightHover,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColor.brownLightActive, width: 1.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12.w,
              children: [
                const Icon(Icons.warning_amber, color: AppColor.brownDarker),
                Text(
                  'لم يتم إدخال البيانات الطبية بعد',
                  style: AppTextStyles.s16.w400.brownDarker,
                ),
              ],
            ),
          ),
          const RSizedBox(height: 16),
          AppButton.filled(
            text: 'إدخال البيانات',
            onPressed: () {
              context.push(AppRoutes.medicalInfo, extra: data);
            },
            isOutlineColor: false,
            buttonColor: AppColor.brownDarker,
          ),
        ],
      ),
    );
  }
}
