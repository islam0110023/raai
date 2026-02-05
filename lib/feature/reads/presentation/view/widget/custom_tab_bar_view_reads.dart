import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/feature/reads/presentation/manager/blood/blood_cubit.dart';
import 'package:raai/feature/reads/presentation/manager/read/read_cubit.dart';
import 'package:raai/feature/reads/presentation/view/widget/custom_alert_dialog.dart';
import 'package:raai/feature/reads/presentation/view/widget/custom_alert_dialog_blood.dart';
import 'package:raai/feature/reads/presentation/view/widget/custom_card_of_reads.dart';

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
            BlocBuilder<ReadCubit, ReadState>(
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
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox();
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
                  return const Center(child: CircularProgressIndicator());
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
