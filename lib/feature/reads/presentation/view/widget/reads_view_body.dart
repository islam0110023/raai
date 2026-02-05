import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/reads/presentation/view/widget/custom_row_feature_reads.dart';
import 'package:raai/feature/reads/presentation/view/widget/custom_tab_bar_view_reads.dart';

class ReadsViewBody extends StatefulWidget {
  const ReadsViewBody({super.key});

  @override
  State<ReadsViewBody> createState() => _ReadsViewBodyState();
}

class _ReadsViewBodyState extends State<ReadsViewBody>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RSizedBox(height: 49),
          Text('القراءات الصحية', style: AppTextStyles.s24.w700.textNormal),
          const RSizedBox(height: 8),
          Text(
            'اخر اضافه : اليوم 10:30 ص',
            style: AppTextStyles.s16.w500.subTextNormal,
          ),
          const RSizedBox(height: 16),
          CustomRowFeatureReads(tabController: tabController),
          const RSizedBox(height: 16),
          CustomTabBarViewReads(tabController: tabController),
        ],
      ),
    );
  }
}
