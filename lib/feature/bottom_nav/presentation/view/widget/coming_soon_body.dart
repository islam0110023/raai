import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';

class ComingSoonBody extends StatelessWidget {
  const ComingSoonBody({super.key, this.isCaregiver = true});
  final bool isCaregiver;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const RSizedBox(width: double.infinity, height: 70),
          Text('قريبًا', style: AppTextStyles.s24.w700.textNormal),
          const RSizedBox(height: 46),
          Image.asset(AppImage.soon, width: 256.w, height: 267.h),
          const SizedBox(width: double.infinity, height: 24),
          Text(
            'الميزه هتكون متاحه قريبًا',
            style: AppTextStyles.s20.w600.textNormal,
          ),
          const RSizedBox(height: 16),
          Text(
            'شغالين علي تطويرها عشان نديك تجربه افضل',
            style: AppTextStyles.s14.w400.subTextNormal,
          ),
          const RSizedBox(height: 128),
          Text(
            'شكراً لصبرك، راعي دايمًا معاك.',
            style: AppTextStyles.s12.w300.subTextNormal,
          ),
          const RSizedBox(height: 16),
          if (isCaregiver)
            AppButton.filled(
              text: 'تسجيل الخروج',
              onPressed: () {
                getIt<AuthCubit>().logout();
              },
            ),
        ],
      ),
    );
  }
}
