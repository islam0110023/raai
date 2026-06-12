import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/error_view.dart';
import 'package:raai/core/widget/no_data_view.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/medication/presenation/manager/medications_data/medications_data_cubit.dart';
import 'package:raai/feature/medication/presenation/view/widget/custom_card_medication.dart';

class MedicationViewBody extends StatelessWidget {
  const MedicationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const RSizedBox(height: 50),
              Text(
                'قائمة أدويتك اليومية',
                style: AppTextStyles.s24.w700.textNormal,
              ),
              const RSizedBox(height: 8),
              Text(
                'اضغط علي الدواء لعرض مزيد من الخيارات',
                style: AppTextStyles.s14.w400.subTextNormal,
              ),
              const RSizedBox(height: 16),
            ],
          ),
        ),

        Expanded(
          child: BlocBuilder<MedicationsDataCubit, MedicationsDataState>(
            builder: (context, state) {
              if (state is MedicationsDataLoading) {
                return RefreshIndicator.adaptive(
                  color: Platform.isAndroid ? AppColor.primaryNormal : null,
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        ShimmerEffect(width: double.infinity, height: 344.h),
                    padding: REdgeInsets.only(
                      bottom: 120,
                      left: 16,
                      right: 16,
                      top: 8,
                    ),
                    separatorBuilder: (context, index) =>
                        const RSizedBox(height: 16),
                    itemCount: 10,
                  ),

                  onRefresh: () async {
                    context.read<MedicationsDataCubit>().getMedications();
                  },
                );
              } else if (state is MedicationsDataSuccess) {
                return RefreshIndicator.adaptive(
                  onRefresh: () async {
                    context.read<MedicationsDataCubit>().getMedications();
                  },
                  color: Platform.isAndroid ? AppColor.primaryNormal : null,

                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return CustomCardMedication(data: state.data[index]);
                    },
                    padding: REdgeInsets.only(
                      bottom: 120,
                      left: 16,
                      right: 16,
                      top: 8,
                    ),
                    separatorBuilder: (context, index) {
                      return const RSizedBox(height: 16);
                    },
                    itemCount: state.data.length,
                  ),
                );
              } else if (state is MedicationsDataFailure) {
                return Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: ErrorView(
                    onPressed: () {
                      context.read<MedicationsDataCubit>().getMedications();
                    },

                    message: state.message,
                  ),
                );
              } else if (state is MedicationsDataNoData) {
                return RefreshIndicator.adaptive(
                  onRefresh: () async {
                    context.read<MedicationsDataCubit>().getMedications();
                  },
                  color: Platform.isAndroid ? AppColor.primaryNormal : null,

                  child: ListView(
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    children: [
                      NoDataView(
                        onPressed: () {
                          context.read<MedicationsDataCubit>().getMedications();
                        },
                        message: 'لا يوجد ادويه بعد',
                        subMessage: 'قم باضافه ادويه من صفحة اضافه الادويه',
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
