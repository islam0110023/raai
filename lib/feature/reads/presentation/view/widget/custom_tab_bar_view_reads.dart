import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/error_view.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/reads/presentation/manager/blood/blood_cubit.dart';
import 'package:raai/feature/reads/presentation/manager/read/read_cubit.dart';
import 'package:raai/feature/reads/presentation/view/widget/custom_alert_dialog.dart';
import 'package:raai/feature/reads/presentation/view/widget/custom_alert_dialog_blood.dart';
import 'package:raai/feature/reads/presentation/view/widget/custom_card_of_reads.dart';
import 'package:raai/feature/reads/presentation/view/widget/custom_card_of_reads_loading.dart';

class CustomTabBarViewReads extends StatelessWidget {
  const CustomTabBarViewReads({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final readCubit = context.read<ReadCubit>();
    final bloodCubit = context.read<BloodCubit>();
    return Expanded(
      child: FractionallySizedBox(
        widthFactor: 1.1,
        child: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BlocConsumer<ReadCubit, ReadState>(
              builder: (context, state) {
                if (state is ReadSugarSuccess) {
                  return RefreshIndicator.adaptive(
                    color: AppColor.primaryNormal,
                    onRefresh: () async {
                      readCubit.getSugarReads();
                    },
                    child: MasonryGridView.count(
                      itemCount: state.data.length,
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: REdgeInsets.fromLTRB(16, 12, 16, 110),
                      itemBuilder: (context, index) {
                        return CustomCardOfReads(
                          isBlood: true,
                          isToday: state.data[index].isEditable,
                          sugarReadEntity: state.data[index],
                          onPressed: () {
                            showDialog(
                              context: context,
                              useSafeArea: false,
                              animationStyle: const AnimationStyle(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              ),
                              builder: (_) {
                                return BlocProvider.value(
                                  value: readCubit,
                                  child: CustomAlertDialog(
                                    id: state.data[index].idCard,
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.h,
                      crossAxisSpacing: 16.w,
                    ),
                  );
                }
                if (state is ReadSugarLoading) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      readCubit.getSugarReads();
                    },
                    child: const CustomCardOfReadsLoading(),
                  );
                }
                if (state is ReadSugarNoData) {
                  return RefreshIndicator.adaptive(
                    onRefresh: () async {
                      readCubit.getSugarReads();
                    },
                    child: ListView(
                      children: [
                        Image.asset(AppImage.soon, width: 256.r, height: 267.r),
                        Text(
                          'لا يوجد قياسات',
                          style: AppTextStyles.s24.w700.textNormal,
                          textAlign: TextAlign.center,
                        ),
                        const RSizedBox(height: 8),
                      ],
                    ),
                  );
                }
                if (state is ReadSugarFailure) {
                  return ErrorView(
                    onPressed: () {
                      readCubit.getSugarReads();
                    },
                  );
                }
                return const SizedBox();
              },
              listener: (context, state) {
                if (state is ReadSugarFailure) {
                  showAnimatedTopSnackBar(
                    context,
                    isError: true,
                    message: 'في مشكلة',
                    subMessage: state.message,
                  );
                }
              },
            ),
            BlocBuilder<BloodCubit, BloodState>(
              builder: (context, state) {
                if (state is ReadBloodSuccess) {
                  return RefreshIndicator.adaptive(
                    color: AppColor.primaryNormal,
                    onRefresh: () async {
                      bloodCubit.getBloodReads();
                    },
                    child: MasonryGridView.count(
                      itemCount: state.data.length,
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: REdgeInsets.fromLTRB(16, 12, 16, 110),
                      itemBuilder: (context, index) {
                        return CustomCardOfReads(
                          isBlood: false,
                          isToday: state.data[index].isEditable,
                          bloodReadEntity: state.data[index],
                          onPressed: () {
                            showDialog(
                              context: context,
                              useSafeArea: false,
                              animationStyle: const AnimationStyle(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              ),
                              builder: (_) {
                                return BlocProvider.value(
                                  value: bloodCubit,
                                  child: CustomAlertDialogBlood(
                                    id: state.data[index].idCard,
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.h,
                      crossAxisSpacing: 16.w,
                    ),
                  );
                }
                if (state is ReadBloodLoading) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      bloodCubit.getBloodReads();
                    },
                    child: const CustomCardOfReadsLoading(),
                  );
                }
                if (state is ReadBloodFailure) {
                  return ErrorView(
                    onPressed: () {
                      bloodCubit.getBloodReads();
                    },
                  );
                }
                if (state is ReadBloodNoData) {
                  return RefreshIndicator.adaptive(
                    onRefresh: () async {
                      bloodCubit.getBloodReads();
                    },
                    child: ListView(
                      children: [
                        Image.asset(AppImage.soon, width: 256.r, height: 267.r),
                        Text(
                          'لا يوجد قياسات',
                          style: AppTextStyles.s24.w700.textNormal,
                          textAlign: TextAlign.center,
                        ),
                        const RSizedBox(height: 8),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
