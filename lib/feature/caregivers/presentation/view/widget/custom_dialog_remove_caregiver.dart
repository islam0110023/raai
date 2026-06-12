import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/feature/caregivers/domain/entity/caregiver_list_entity.dart';

class CustomDialogRemoveCaregiver extends StatelessWidget {
  const CustomDialogRemoveCaregiver({super.key, required this.data});
  final CaregiverListEntity data;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: REdgeInsets.symmetric(horizontal: 0),
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
        margin: REdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColor.disableLightActive, width: 1.r),
          boxShadow: const [
            BoxShadow(
              color: AppColor.shadowColor,
              blurRadius: 12,
              offset: Offset(0, 0),
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppIcons.alertWarning, width: 60.r, height: 60.r),
            const RSizedBox(height: 16),
            Text('تأكيد الإزالة', style: AppTextStyles.s20.w600.textNormal),
            const RSizedBox(height: 16),
            Text(
              'هل أنت متأكد من إزالة هذاالمرافق من قائمة المرافقين؟',
              style: AppTextStyles.s16.w500.subTextNormal,
              textAlign: TextAlign.center,
            ),
            const RSizedBox(height: 8),
            Text(
              'لن يتمكن بعد الآن من متابعة بياناتك الصحية.',
              style: AppTextStyles.s14.w400.redDarker,
            ),
            const RSizedBox(height: 24),
            Row(
              spacing: 8.w,
              children: [
                Expanded(
                  child: AppButton.filled(
                    text: 'الغاء',
                    onPressed: () {
                      context.pop();
                    },
                    textStyle: AppTextStyles.s14.w400.white,
                    isOutlineColor: false,
                    padding: REdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                  ),
                ),
                Expanded(
                  child: AppButton.outline(
                    text: 'إزالة',
                    onPressed: () {},
                    isOutlineColor: false,
                    textStyle: AppTextStyles.s14.w400.redDarker,
                    borderColor: AppColor.redDarkHover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
