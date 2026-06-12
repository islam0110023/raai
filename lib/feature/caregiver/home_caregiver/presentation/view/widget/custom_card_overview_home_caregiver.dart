import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/manager/home_caregiver/home_caregiver_cubit.dart';

class CustomCardOverviewHomeCaregiver extends StatelessWidget {
  const CustomCardOverviewHomeCaregiver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCaregiverCubit, HomeCaregiverState>(
      builder: (context, state) {
        if (state is HomeCaregiverLoading) {
          return ShimmerEffect(width: double.infinity, height: 111.h);
        }
        if (state is HomeCaregiverSuccess) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('نظرة عامة', style: AppTextStyles.s20.w600.textNormal),
                const RSizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: REdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.redLight,
                        borderRadius: BorderRadius.circular(180.r),
                        border: Border.all(
                          color: AppColor.redLightActive,
                          width: 1.r,
                        ),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColor.redDarkHover,
                            radius: 6,
                          ),
                          const RSizedBox(width: 8),
                          Text(
                            '${state.data.critical} خطر',
                            style: AppTextStyles.s12.w400.redDarkHover,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: REdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.brownLightHover,
                        borderRadius: BorderRadius.circular(180.r),
                        border: Border.all(
                          color: AppColor.brownLightActive,
                          width: 1.r,
                        ),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColor.brownDarker,
                            radius: 6,
                          ),
                          const RSizedBox(width: 8),
                          Text(
                            '${state.data.warning} يحتاج متابعة',
                            style: AppTextStyles.s12.w400.brownDarker,
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: REdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.greenLightHover,
                        borderRadius: BorderRadius.circular(180.r),
                        border: Border.all(
                          color: AppColor.greenLightActive,
                          width: 1.r,
                        ),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColor.greenDark,
                            radius: 6,
                          ),
                          const RSizedBox(width: 8),
                          Text(
                            '${state.data.good} مطمئن',
                            style: AppTextStyles.s12.w400.greenDarker,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
