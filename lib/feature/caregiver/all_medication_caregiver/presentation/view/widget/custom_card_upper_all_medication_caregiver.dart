import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/presentation/manager/all_medication_caregiver/all_medication_caregiver_cubit.dart';

class CustomCardUpperAllMedicationCaregiver extends StatelessWidget {
  const CustomCardUpperAllMedicationCaregiver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      AllMedicationCaregiverCubit,
      AllMedicationCaregiverState
    >(
      builder: (context, state) {
        if (state is AllMedicationCaregiverLoading) {
          return ShimmerEffect(height: 100.h, width: double.infinity);
        }
        if (state is AllMedicationCaregiverSuccess) {
          return Container(
            padding: REdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: AppColor.primaryNormal,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ListTile(
              title: Text(
                'ملخص اليوم',
                style: AppTextStyles.s16.w600.primaryLight,
              ),
              subtitle: Padding(
                padding: REdgeInsets.only(top: 8),
                child: Text(
                  AppConstant.buildMedicationSummary(
                    taken: state.data.taken,
                    missed: state.data.missed,
                    upcoming: state.data.upcoming,
                    snoozed: state.data.snoozed,
                  ),
                  style: AppTextStyles.s14.w400.primaryLight,
                ),
              ),
              trailing: CircleAvatar(
                backgroundColor: AppColor.white.withAlpha(51),
                radius: 30,
                child: SvgPicture.asset(
                  AppIcons.tabletMedicine,
                  width: 23.w,
                  colorFilter: const ColorFilter.mode(
                    AppColor.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
