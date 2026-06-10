import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/medication/data/model/input_medication_model.dart';
import 'package:raai/feature/medication/presenation/manager/medication_form_cubit.dart';

class CustomTabBarMedication extends StatefulWidget {
  const CustomTabBarMedication({super.key});

  @override
  State<CustomTabBarMedication> createState() => _CustomTabBarMedicationState();
}

class _CustomTabBarMedicationState extends State<CustomTabBarMedication>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    context.read<MedicationFormCubit>().updateRepeatType('DAILY');
    tabController.addListener(() {
      if (tabController.indexIsChanging) return;

      context.read<MedicationFormCubit>().updateRepeatType(
        tabController.index == 0 ? 'DAILY' : 'WEEKLY',
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColor.disableLightHover,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: TabBar(
            controller: tabController,
            indicator: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(18.r),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: AppTextStyles.s16.w700.primaryNormal,
            unselectedLabelStyle: AppTextStyles.s16.w700.textNormal,
            padding: REdgeInsets.all(4),
            labelPadding: REdgeInsets.symmetric(vertical: 12),
            splashBorderRadius: BorderRadius.circular(24.r),

            dividerColor: Colors.transparent,
            tabs: const [Text('يومي'), Text('اسبوعي')],
          ),
        ),
        const RSizedBox(height: 8),
        FractionallySizedBox(
          widthFactor: 1.1,
          child: SizedBox(
            height: 157.h,
            child: TabBarView(
              controller: tabController,
              children: [
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  margin: REdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border(
                      right: BorderSide(
                        color: AppColor.primaryNormal,
                        width: 4.w,
                      ),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadowColor,
                        blurRadius: 12,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'عدد الجرعات في اليوم',
                        style: AppTextStyles.s16.w700.black,
                      ),
                      const RSizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              context
                                  .read<MedicationFormCubit>()
                                  .decrementDoses();
                            },
                            elevation: 0,
                            heroTag: null,
                            backgroundColor: AppColor.disableNormal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(180.r),
                            ),
                            splashColor: AppColor.disableNormalHover,
                            child: const Icon(
                              Icons.remove,
                              color: AppColor.black,
                            ),
                          ),
                          BlocBuilder<
                            MedicationFormCubit,
                            InputMedicationModel
                          >(
                            builder: (context, state) {
                              return Text(
                                state.dosesPerDay.toString(),
                                style: AppTextStyles.s24.w700.black,
                              );
                            },
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              context
                                  .read<MedicationFormCubit>()
                                  .incrementDoses();
                            },
                            elevation: 0,
                            heroTag: null,

                            backgroundColor: AppColor.primaryNormal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(180.r),
                            ),
                            splashColor: AppColor.primaryNormalHover,
                            hoverColor: AppColor.primaryNormalHover,
                            child: const Icon(Icons.add, color: AppColor.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  margin: REdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border(
                      left: BorderSide(
                        color: AppColor.primaryNormal,
                        width: 4.w,
                      ),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadowColor,
                        blurRadius: 12,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('كل كام يوم؟', style: AppTextStyles.s16.w700.black),
                      const RSizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              context
                                  .read<MedicationFormCubit>()
                                  .decrementDoses();
                            },
                            elevation: 0,
                            heroTag: null,

                            backgroundColor: AppColor.disableNormal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(180.r),
                            ),
                            splashColor: AppColor.disableNormalHover,
                            child: const Icon(
                              Icons.remove,
                              color: AppColor.black,
                            ),
                          ),
                          BlocBuilder<
                            MedicationFormCubit,
                            InputMedicationModel
                          >(
                            builder: (context, state) {
                              return Text(
                                state.dosesPerDay.toString(),
                                style: AppTextStyles.s24.w700.black,
                              );
                            },
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              context
                                  .read<MedicationFormCubit>()
                                  .incrementDoses();
                            },
                            elevation: 0,
                            heroTag: null,

                            backgroundColor: AppColor.primaryNormal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(180.r),
                            ),
                            splashColor: AppColor.primaryNormalHover,
                            hoverColor: AppColor.primaryNormalHover,
                            child: const Icon(Icons.add, color: AppColor.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
