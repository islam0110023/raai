import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/home/presentation/manager/home_data/home_data_cubit.dart';

class CustomStatusHomeView extends StatelessWidget {
  const CustomStatusHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDataCubit, HomeDataState>(
      builder: (context, state) {
        if (state is HomeDataSuccess) {
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: REdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: state.homeData.trafficBackgroundColor,
                borderRadius: BorderRadius.circular(45),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: state.homeData.trafficColor,
                    radius: 8.r,
                  ),
                  const RSizedBox(width: 8),
                  Text(
                    'حالتك اليوم:',
                    style: AppTextStyles.s16.w500.subTextNormal,
                  ),
                  const RSizedBox(width: 4),
                  Text(
                    state.homeData.status,
                    style: AppTextStyles.s16.w500.greenNormal.copyWith(
                      color: state.homeData.trafficColor,
                    ),
                  ),
                  const RSizedBox(width: 50),
                ],
              ),
            ),
          );
        }
        if (state is HomeDataLoading) {
          return Align(
            alignment: Alignment.centerRight,
            child: ShimmerEffect(radius: 45, width: 280.w, height: 40.h),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
