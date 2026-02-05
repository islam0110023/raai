import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/feature/medical_information/presentation/view/widget/custom_confirm_upper_animation.dart';

class ConfirmationScreenBody extends StatelessWidget {
  const ConfirmationScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16),
      child: Column(
        children: [
          const RSizedBox(height: 130),
          const CustomConfirmUpperAnimation(),
          const RSizedBox(height: 64),
          Text('تم الانتهاء بنجاح!', style: AppTextStyles.s24.w700.textNormal),
          const RSizedBox(height: 24),
          SizedBox(
            width: 269.w,
            child: Text(
              textAlign: TextAlign.center,
              'لقد أكملت جميع الأسئلة بنجاح. بياناتك قيمة وستساعدنا في تقديم رعاية أفضل لك.',
              style: AppTextStyles.s16.w500.subTextNormal,
            ),
          ),
          const RSizedBox(height: 100),
          AppButton.filled(
            text: 'انهاء',
            onPressed: () {
              context.go(AppRoutes.homeScreen);
            },
          ),
        ],
      ),
    );
  }
}
