import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/profile/presentation/manager/profile/profile_cubit.dart';
import 'package:raai/feature/profile/presentation/view/widget/custom_card_last_read.dart';
import 'package:raai/feature/profile/presentation/view/widget/custom_card_last_read_no_data.dart';

class CustomListLastReadingHome extends StatelessWidget {
  const CustomListLastReadingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Row(
            children: [
              Expanded(child: ShimmerEffect(height: 82, radius: 24)),
              RSizedBox(width: 16),

              Expanded(child: ShimmerEffect(height: 82, radius: 24)),
            ],
          );
        }
        if (state is ProfileSuccess) {
          return Row(
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
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
