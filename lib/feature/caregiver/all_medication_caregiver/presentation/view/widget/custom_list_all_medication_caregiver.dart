import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/presentation/manager/all_medication_caregiver/all_medication_caregiver_cubit.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/presentation/view/widget/custom_card_not_taken.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/presentation/view/widget/custom_card_snooze.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/presentation/view/widget/custom_card_taken.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/presentation/view/widget/custom_card_up_coming.dart';

class CustomListAllMedicationCaregiver extends StatelessWidget {
  const CustomListAllMedicationCaregiver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      AllMedicationCaregiverCubit,
      AllMedicationCaregiverState
    >(
      builder: (context, state) {
        if (state is AllMedicationCaregiverSuccess) {
          return SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                final dose = state.data.doses[index];
                return switch (dose.statusCode) {
                  'TAKEN' => CustomCardTaken(dose: dose),
                  'MISSED' => CustomCardNotTaken(dose: dose),
                  'UPCOMING' => CustomCardUpComing(dose: dose),
                  'SNOOZE' => CustomCardSnooze(dose: dose),
                  _ => const SizedBox.shrink(),
                };
              },
              separatorBuilder: (context, index) {
                return const RSizedBox(height: 16);
              },
              itemCount: state.data.doses.length,
            ),
          );
        }
        if (state is AllMedicationCaregiverLoading) {
          return SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                return ShimmerEffect(width: double.infinity, height: 168.h);
              },
              separatorBuilder: (context, index) {
                return const RSizedBox(height: 16);
              },
              itemCount: 10,
            ),
          );
        }
        return const SliverToBoxAdapter();
      },
    );
  }
}
