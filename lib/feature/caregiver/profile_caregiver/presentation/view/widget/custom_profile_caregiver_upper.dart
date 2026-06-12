import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/caregiver/profile_caregiver/presentation/manager/profile_caregiver/profile_caregiver_cubit.dart';

class CustomProfileCaregiverUpper extends StatelessWidget {
  const CustomProfileCaregiverUpper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCaregiverCubit, ProfileCaregiverState>(
      builder: (context, state) {
        if (state is ProfileCaregiverSuccess) {
          return Column(
            children: [
              const RSizedBox(height: 70),

              CircleAvatar(
                radius: 60.r,
                backgroundImage: AssetImage(
                  state.data.gender == 'MALE'
                      ? AppImage.avatarMale
                      : AppImage.avatarFemale,
                ),
              ),
              const RSizedBox(height: 8),
              ShimmerEffect(
                highlightColor: AppColor.black,
                baseColor: AppColor.subtextNormal,
                child: Text(
                  state.data.fullName,
                  style: AppTextStyles.s20.w600.textNormal,
                ),
              ),
              const RSizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: state.data.phone,
                      style: AppTextStyles.s14.w400.subTextNormal,
                    ),
                    TextSpan(
                      text: ' 02+',
                      style: AppTextStyles.s14.w400.subTextNormal,
                    ),
                  ],
                ),
              ),
              // Text(
              //   '+02${state.data.phone}',
              //   style: AppTextStyles.s14.w400.subTextNormal,
              // ),
              const RSizedBox(height: 4),
              Container(
                padding: REdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColor.secondaryLightHover,
                  borderRadius: BorderRadius.circular(45.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  textBaseline: TextBaseline.ideographic,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.person_2,
                      color: AppColor.greenDarkActive,
                      size: 16.r,
                    ),
                    const RSizedBox(width: 4),
                    Text(
                      '${state.data.elderCount} مسنون مرتبطون',
                      style: AppTextStyles.s14.w400.greenDarkActive,
                    ),
                  ],
                ),
              ),
              const RSizedBox(height: 32),
            ],
          );
        }
        if (state is ProfileCaregiverLoading) {
          return Column(
            children: [
              const RSizedBox(height: 70),

              ShimmerEffect(child: CircleAvatar(radius: 60.r)),
              const RSizedBox(height: 8),
              ShimmerEffect(
                color: AppColor.black,
                width: 180.w,
                height: 25.h,
                radius: 4,
              ),
              const RSizedBox(height: 4),
              ShimmerEffect(
                color: AppColor.black,
                width: 130.w,
                height: 25.h,
                radius: 4,
              ),
              const RSizedBox(height: 4),
              ShimmerEffect(
                color: AppColor.black,
                width: 160.w,
                height: 25.h,
                radius: 45.r,
              ),
              const RSizedBox(height: 32),
            ],
          );
        }
        return const RSizedBox(height: 70);
      },
    );
  }
}
