import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/error_view.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/home/presentation/manager/home_data/home_data_cubit.dart';
import 'package:raai/feature/home/presentation/view/widget/custom_card_medicine_home.dart';
import 'package:raai/feature/home/presentation/view/widget/custom_card_online_caregiver.dart';
import 'package:raai/feature/home/presentation/view/widget/custom_layout_in_home_view.dart';
import 'package:raai/feature/home/presentation/view/widget/custom_list_last_reading_home.dart';
import 'package:raai/feature/home/presentation/view/widget/custom_status_home_view.dart';
import 'package:raai/feature/home/presentation/view/widget/custom_upper_home_view.dart';
import 'package:raai/feature/profile/presentation/manager/profile/profile_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDataCubit, HomeDataState>(
      builder: (context, state) {
        if (state is HomeDataFailure) {
          return Padding(
            padding: REdgeInsets.only(left: 16, right: 16, top: 130),
            child: ErrorView(
              onPressed: () {
                context.read<HomeDataCubit>().getHomeData();
                context.read<ProfileCubit>().getUserProfile();
              },
              message: state.message,
            ),
          );
        }
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            context.read<HomeDataCubit>().getHomeData();
            context.read<ProfileCubit>().getUserProfile();
          },
          edgeOffset: 50.h,
          child: ListView(
            padding: REdgeInsets.symmetric(horizontal: 16),
            children: [
              const RSizedBox(height: 50),
              const CustomUpperHomeView(),
              const RSizedBox(height: 8),
              const CustomStatusHomeView(),
              const RSizedBox(height: 16),
              const CustomListLastReadingHome(),
              if (state is HomeDataSuccess &&
                  state.homeData.medicationId != null) ...[
                const RSizedBox(height: 16),
                Text('الدواء القادم', style: AppTextStyles.s16.w500.textNormal),
                const RSizedBox(height: 16),
                const CustomCardMedicineHome(),
              ],
              if (state is HomeDataLoading) ...[
                const RSizedBox(height: 16),
                Text('الدواء القادم', style: AppTextStyles.s16.w500.textNormal),
                const RSizedBox(height: 16),
                ShimmerEffect(height: 146.h, width: double.infinity),
              ],
              const RSizedBox(height: 16),
              Text('أختصارات', style: AppTextStyles.s16.w500.textNormal),
              const RSizedBox(height: 16),
              const CustomLayoutInHomeView(),
              if (state is HomeDataSuccess &&
                  state.homeData.caregiverId != null) ...[
                const RSizedBox(height: 16),
                Text(
                  'مرافقين متصلين',
                  style: AppTextStyles.s16.w500.textNormal,
                ),
                const RSizedBox(height: 16),
                const CustomCardOnlineCaregiver(),
              ],
              if (state is HomeDataLoading) ...[
                const RSizedBox(height: 16),
                Text(
                  'مرافقين متصلين',
                  style: AppTextStyles.s16.w500.textNormal,
                ),
                const RSizedBox(height: 16),
                ShimmerEffect(height: 50.h, width: double.infinity),
              ],
              const RSizedBox(height: 160),
            ],
          ),
        );
      },
    );
  }
}
