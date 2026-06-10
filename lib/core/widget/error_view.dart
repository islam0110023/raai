import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/app_button_back.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.onPressed,
    this.isExpanded = false,
    this.message,
  });
  final VoidCallback? onPressed;
  final String? message;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (isExpanded) const RSizedBox(height: 55),
          if (isExpanded)
            Align(
              alignment: AlignmentDirectional.topStart,
              child: AppButtonBack(
                onPressed: () {
                  context.pop();
                },
                isLabel: false,
              ),
            ),
          if (isExpanded) const RSizedBox(height: 16),

          const RSizedBox(height: 16),
          SvgPicture.asset(AppIcons.warningDesktop),
          const RSizedBox(height: 24),
          Text('حدث خطأ بسيط', style: AppTextStyles.s16.w500.textNormal),
          const RSizedBox(height: 16),

          Image.asset(AppImage.error1, width: 200.r, height: 200.r),
          const RSizedBox(height: 24),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 26),
            child: Text(
              message ?? 'حصلت مشكلة أثناء تنفيذ الطلب، حاول مرة أخرى',
              style: AppTextStyles.s16.w500.textNormal,
              textAlign: TextAlign.center,
            ),
          ),
          const RSizedBox(height: 24),
          if (isExpanded) const RSizedBox(height: 120),

          AppButton.filled(
            text: 'إعادة المحاولة',
            onPressed: onPressed ?? () {},
          ),
        ],
      ),
    );
  }
}
