import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_drop_down_field.dart';
import 'package:raai/core/widget/error_view.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/entity/all_elder_all_medication_caregiver_entity.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/presentation/manager/all_medication_caregiver/all_medication_caregiver_cubit.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/presentation/view/widget/custom_card_upper_all_medication_caregiver.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/presentation/view/widget/custom_list_all_medication_caregiver.dart';

class AllMedicationCaregiverViewBody extends StatelessWidget {
  const AllMedicationCaregiverViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      AllMedicationCaregiverCubit,
      AllMedicationCaregiverState
    >(
      builder: (context, state) {
        if (state is AllMedicationCaregiverFailure) {
          return Padding(
            padding: REdgeInsets.only(left: 16, right: 16, top: 130),
            child: ErrorView(
              onPressed: () {
                context
                    .read<AllMedicationCaregiverCubit>()
                    .getAllMedicationInCaregiver();
              },
              message: state.message,
            ),
          );
        }

        return RefreshIndicator.adaptive(
          onRefresh: () async {
            context
                .read<AllMedicationCaregiverCubit>()
                .getAllMedicationInCaregiver();
          },
          color: Platform.isAndroid ? AppColor.primaryNormal : null,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const RSizedBox(height: 55),
                      Text('الأدويه', style: AppTextStyles.s28.w700.textNormal),
                      const RSizedBox(height: 21),
                      const CustomCardUpperAllMedicationCaregiver(),
                      const RSizedBox(height: 16),
                      BlocBuilder<
                        AllMedicationCaregiverCubit,
                        AllMedicationCaregiverState
                      >(
                        builder: (context, state) {
                          if (state is AllMedicationCaregiverLoading) {
                            return ShimmerEffect(
                              height: 82.h,
                              width: double.infinity,
                            );
                          }
                          if (state is AllMedicationCaregiverSuccess) {
                            final elders = [
                              AllElderAllMedicationCaregiverEntity(
                                id: -1,
                                name: 'الكل',
                              ),
                              ...state.data.elders,
                            ];
                            return AppDropDownField<
                              AllElderAllMedicationCaregiverEntity
                            >(
                              options: elders,
                              onChanged: (selected) {
                                if (selected.isEmpty) return;

                                final elder = selected.first;

                                if (elder.id == -1) {
                                  context
                                      .read<AllMedicationCaregiverCubit>()
                                      .clearFilter();
                                } else {
                                  context
                                      .read<AllMedicationCaregiverCubit>()
                                      .filterByElder(elder.id);
                                }
                              },
                              label: 'اختر المسن',
                              hint: 'الكل',
                              multiSelect: false,
                              itemTitle: (item) {
                                return item.name;
                              },
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const RSizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              const CustomListAllMedicationCaregiver(),
              const SliverToBoxAdapter(child: RSizedBox(height: 150)),
            ],
          ),
        );
      },
    );
  }
}
