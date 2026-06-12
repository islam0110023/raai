import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/manager/home_caregiver/home_caregiver_cubit.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/view/widget/custom_card_caregiver_home_elder_with_fill_data.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/view/widget/custom_card_caregiver_home_elder_with_no_data.dart';

class CustomListEldersCaregiverHome extends StatelessWidget {
  const CustomListEldersCaregiverHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCaregiverCubit, HomeCaregiverState>(
      builder: (context, state) {
        if (state is HomeCaregiverLoading) {
          return SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                return ShimmerEffect(width: double.infinity, height: 230.h);
              },
              separatorBuilder: (context, index) {
                return const RSizedBox(height: 10);
              },
              itemCount: 5,
            ),
          );
        }
        if (state is HomeCaregiverSuccess) {
          if (state.data.elders.isEmpty) {
            return SliverPadding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              sliver: SliverFillRemaining(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لا يوجد مسنين الان',
                      style: AppTextStyles.s20.w600.textNormal,
                    ),
                    const RSizedBox(height: 16),
                    Text(
                      'اذهب الي صفحة اضافة مسنين\n واضيف مسنين',
                      style: AppTextStyles.s14.w500.subTextNormal,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                return state.data.elders[index].healthProfileCompleted == true
                    ? CustomCardCaregiverHomeElderWithFillData(
                        data: state.data.elders[index],
                      )
                    : CustomCardCaregiverHomeElderWithNoData(
                        data: state.data.elders[index],
                      );
              },
              separatorBuilder: (context, index) {
                return const RSizedBox(height: 10);
              },
              itemCount: state.data.elders.length,
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
