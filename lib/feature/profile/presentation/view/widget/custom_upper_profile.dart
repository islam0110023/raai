import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/profile/presentation/manager/profile/profile_cubit.dart';
import 'package:raai/feature/profile/presentation/view/widget/custom_card_last_read.dart';
import 'package:raai/feature/profile/presentation/view/widget/custom_card_last_read_no_data.dart';

class CustomUpperProfile extends StatelessWidget {
  const CustomUpperProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccess) {
          return Column(
            children: [
              const RSizedBox(height: 70),

              CircleAvatar(
                radius: 60.r,
                backgroundImage: AssetImage(
                  state.profile.personalData.gender == 'MALE'
                      ? AppImage.avatarMale
                      : AppImage.avatarFemale,
                ),
              ),
              const RSizedBox(height: 8),
              Text(
                state.profile.personalData.fullName,
                style: AppTextStyles.s20.w600.textNormal,
              ),
              const RSizedBox(height: 4),
              Text(
                '${state.profile.personalData.age} . سنة',
                style: AppTextStyles.s12.w300.subTextNormal,
              ),
              const RSizedBox(height: 4),
              Container(
                padding: REdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: state.profile.trafficBackgroundColor,
                  borderRadius: BorderRadius.circular(45.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  textBaseline: TextBaseline.ideographic,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'حاله صحية عامه:',
                      style: AppTextStyles.s12.w300.subTextNormal,
                    ),
                    const RSizedBox(width: 4),
                    Text(
                      state.profile.status,
                      style: AppTextStyles.s12.w300.textNormal.copyWith(
                        color: state.profile.trafficColor,
                      ),
                    ),
                    const RSizedBox(width: 4),
                    Container(
                      width: 12.r,
                      height: 12.r,
                      decoration: ShapeDecoration(
                        color: state.profile.trafficColor,
                        shape: const OvalBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              const RSizedBox(height: 24),
              Row(
                children: [
                  Visibility(
                    visible: state.profile.sugarProfile != null,
                    replacement: const Expanded(
                      child: CustomCardLastReadNoData(isBlood: true),
                    ),
                    child: Expanded(
                      child: CustomCardLastRead(
                        isBlood: true,
                        profile: state.profile,
                      ),
                    ),
                  ),
                  const RSizedBox(width: 16),
                  Visibility(
                    visible: state.profile.bloodProfile != null,
                    replacement: const Expanded(
                      child: CustomCardLastReadNoData(isBlood: false),
                    ),

                    child: Expanded(
                      child: CustomCardLastRead(
                        isBlood: false,
                        profile: state.profile,
                      ),
                    ),
                  ),
                ],
              ),
              const RSizedBox(height: 32),
            ],
          );
        }
        if (state is ProfileLoading) {
          return Column(
            children: [
              const RSizedBox(height: 70),
              ShimmerEffect(
                child: CircleAvatar(
                  radius: 60.r,
                  backgroundImage: const AssetImage(AppImage.avatarFemale),
                ),
              ),
              const RSizedBox(height: 8),
              const ShimmerEffect(width: 200, height: 25, radius: 0),
              const RSizedBox(height: 4),
              const ShimmerEffect(width: 100, height: 15, radius: 0),

              const RSizedBox(height: 4),
              const ShimmerEffect(radius: 45, width: 161, height: 23),
              const RSizedBox(height: 24),
              const Row(
                children: [
                  Expanded(child: ShimmerEffect(height: 82, radius: 24)),
                  RSizedBox(width: 16),

                  Expanded(child: ShimmerEffect(height: 82, radius: 24)),
                ],
              ),

              const RSizedBox(height: 32),
            ],
          );
        }
        return const SizedBox(height: 70);
      },
    );
  }
}
