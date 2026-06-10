import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/medication/presenation/manager/medication_form_cubit.dart';

class CustomTabsBarWithFood extends StatefulWidget {
  const CustomTabsBarWithFood({super.key});

  @override
  State<CustomTabsBarWithFood> createState() => _CustomTabsBarWithFoodState();
}

class _CustomTabsBarWithFoodState extends State<CustomTabsBarWithFood>
    with TickerProviderStateMixin {
  late TabController tabController1;
  late TabController tabController2;
  bool showSecondTab = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController1 = TabController(length: 2, vsync: this);
    tabController2 = TabController(length: 2, vsync: this);
    context.read<MedicationFormCubit>().updateWithFood(true);

    context.read<MedicationFormCubit>().updateFoodTiming('BEFORE');

    tabController1.addListener(() {
      if (!tabController1.indexIsChanging) {
        final cubit = context.read<MedicationFormCubit>();

        setState(() {
          showSecondTab = tabController1.index == 0;
        });

        if (tabController1.index == 0) {
          cubit.updateWithFood(true);
        } else {
          cubit.updateWithFood(false);
          cubit.updateFoodTiming(null);
        }
      }
    });
    tabController2.addListener(() {
      if (!tabController2.indexIsChanging) {
        context.read<MedicationFormCubit>().updateFoodTiming(
          tabController2.index == 0 ? 'BEFORE' : 'AFTER',
        );
      }
    });
  }

  @override
  void dispose() {
    tabController1.dispose();
    tabController2.dispose();
    super.dispose();
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
            controller: tabController1,
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
            tabs: const [Text('نعم'), Text('لا')],
          ),
        ),
        if (showSecondTab) ...[
          const RSizedBox(height: 8),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColor.disableLightHover,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: TabBar(
              controller: tabController2,
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
              tabs: const [Text('قبل'), Text('بعد')],
            ),
          ),
        ],
      ],
    );
  }
}
