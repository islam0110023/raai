import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/custom_app_bar_app.dart';
import 'package:raai/feature/models/presentation/view/wadget/custom_card_select_model.dart';

class SelectModelsScreenBody extends StatelessWidget {
  const SelectModelsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const RSizedBox(height: 55),
          const CustomAppBarApp(title: 'اختر نوع الفحص'),
          const RSizedBox(height: 24),
          Text(
            'اختر نوع الفحص المناسب ليك\nراعي هيحلل بياناتك و يطمن علي صحتك',
            style: AppTextStyles.s16.w500.subTextNormal,
            textAlign: TextAlign.center,
          ),
          const RSizedBox(height: 40),
          CustomCardSelectModel(
            title: 'فحص سكر الدم (شهري)',
            subtitle: 'متابعه تحاليل السكر',
            icon: AppIcons.blood,
            onTap: () {
              context.push(AppRoutes.sugarMonthlyModel);
            },
          ),
          // const RSizedBox(height: 16),
          // CustomCardSelectModel(
          //   title: 'فحص سكر الدم (يومي)',
          //   subtitle: 'متابعه تحاليل السكر',
          //   icon: AppIcons.blood,
          //   onTap: () {
          //     context.push(AppRoutes.sugarDailyModel);
          //   },
          // ),
          const RSizedBox(height: 16),

          // const CustomCardSelectModel(
          //   title: 'فحص ضغط الدم',
          //   subtitle: 'متابعه تحاليل الضغط',
          //   icon: AppIcons.heart,
          // ),
          const CustomCardSelectModel(
            title: 'فحوصات اخري',
            subtitle: '(قريبا)',
            icon: AppIcons.plusIcon,
            color: AppColor.primaryNormal,
          ),
        ],
      ),
    );
  }
}
