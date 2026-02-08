import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/custom_app_bar_app.dart';
import 'package:raai/feature/models/presentation/manager/sugar_daily/sugar_daily_cubit.dart';
import 'package:raai/feature/models/presentation/view/wadget/custom_card_reads_model.dart';
import 'package:raai/feature/models/presentation/view/wadget/custom_circle_range_daily.dart';

class CustomSuccessSugarDailyModel extends StatelessWidget {
  const CustomSuccessSugarDailyModel({super.key, required this.state});
  final SugarDailySuccess state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          floating: true,
          flexibleSpace: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: const Column(
              children: [
                RSizedBox(height: 55),
                CustomAppBarApp(title: 'نتيجه الفحص'),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const RSizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: REdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: state.data.backgroundTrafficColor,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomCircleRangeDaily(state: state),
                      Text(
                        'الحاله : ${state.data.status}',
                        style: AppTextStyles.s24.w700.textNormal,
                      ),
                      const RSizedBox(height: 8),
                      Text(
                        state.data.description,
                        style: AppTextStyles.s20.w600.subTextNormal,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const RSizedBox(height: 24),
                Container(
                  padding: REdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: AppColor.secondaryLightActive,
                      width: 1.r,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadowColor,
                        offset: Offset(0, 0),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'تعليمات سريعة',
                        style: AppTextStyles.s16.w500.textNormal,
                      ),
                      const RSizedBox(height: 8),
                      Text(
                        state.data.statement,
                        style: AppTextStyles.s14.w400.subTextNormal,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                const RSizedBox(height: 24),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: CustomCardReadsModel(
            title: 'القراءات السابقه',
            items: state.data.lastReadings,
            isDaily: false,
          ),
        ),
        const SliverToBoxAdapter(child: RSizedBox(height: 44)),
      ],
    );
  }
}
