import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/error_view.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/manager/home_caregiver/home_caregiver_cubit.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/view/widget/custom_card_overview_home_caregiver.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/view/widget/custom_list_elders_caregiver_home.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/view/widget/custom_upper_home_caregiver.dart';

class HomeCaregiverBodyView extends StatelessWidget {
  const HomeCaregiverBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCaregiverCubit, HomeCaregiverState>(
      builder: (context, state) {
        if (state is HomeCaregiverFailure) {
          return Padding(
            padding: REdgeInsets.only(left: 16, right: 16, top: 130),
            child: ErrorView(
              onPressed: () {
                context.read<HomeCaregiverCubit>().getHomeCaregiverData();
              },
              message: state.message,
            ),
          );
        }
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            context.read<HomeCaregiverCubit>().getHomeCaregiverData();
          },
          color: Platform.isAndroid ? AppColor.primaryNormal : null,

          edgeOffset: 50,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const RSizedBox(height: 55),
                      const CustomUpperHomeCaregiver(),
                      const RSizedBox(height: 24),
                      const CustomCardOverviewHomeCaregiver(),
                      const RSizedBox(height: 16),
                      Text(
                        'المسنون المرتبطون',
                        style: AppTextStyles.s16.w500.textNormal,
                      ),
                      const RSizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              const CustomListEldersCaregiverHome(),
              const SliverToBoxAdapter(child: RSizedBox(height: 150)),
            ],
          ),
        );
      },
    );
  }
}
