import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_list_select_role.dart';

class SelectRoleScreenBody extends StatelessWidget {
  const SelectRoleScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16),
      child: Column(
        children: [
          const RSizedBox(height: 64),
          Text(
            'حدد هويتك',
            textAlign: TextAlign.center,
            style: AppTextStyles.s24.w700.textNormal,
          ),
          const RSizedBox(height: 24),
          Text(
            'اختر الدور الذي تمثله في تطبيق راعي، لتبدأ رحلتك في المتابعة والرعاية الصحية الذكية.',
            textAlign: TextAlign.center,
            style: AppTextStyles.s16.w500.subTextNormal,
          ),
          const RSizedBox(height: 50),
          const CustomListSelectRole(),
          const RSizedBox(height: 40),
          AppButton.filled(
            text: 'تأكيد',
            onPressed: () {
              context.push(AppRoutes.medicalInfo);
            },
          ),
        ],
      ),
    );
  }
}
