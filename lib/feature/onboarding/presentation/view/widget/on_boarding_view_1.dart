import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';

class OnBoardingView1 extends StatelessWidget {
  const OnBoardingView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RSizedBox(height: 84),
        Text('أهلاً بيك فى راعي!', style: AppTextStyles.s24.w700.textNormal),
        const RSizedBox(height: 24),
        Text(
          textAlign: TextAlign.center,
          'تطبيق سهل ومريح! كلمني وقول لي.. أنا هنا أسمعك وأفهمك باللهجة المصرية عشان أسهّل عليك كل حاجة.',
          style: AppTextStyles.s16.w500.subTextNormal,
        ),
        const RSizedBox(height: 50),
        Image.asset(
          AppImage.speaking,
          width: 208.r,
          height: 208.r,
          fit: BoxFit.cover,
        ),
        const RSizedBox(height: 28),
        Row(
          spacing: 16.w,
          children: [
            Expanded(
              child: Container(
                padding: REdgeInsets.symmetric(horizontal: 64, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColor.primaryNormal,
                  borderRadius: BorderRadius.circular(45.r),
                ),
                child: SvgPicture.asset(AppIcons.voiceSound),
              ),
            ),
            Expanded(
              child: Container(
                padding: REdgeInsets.symmetric(horizontal: 64, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColor.primaryNormal,
                  borderRadius: BorderRadius.circular(45.r),
                ),
                child: SvgPicture.asset(AppIcons.fingerScan),
              ),
            ),
          ],
        ),
        const RSizedBox(height: 24),
        Text(
          'لتفاعل بالصوت أو اللمس',
          style: AppTextStyles.s14.w400.subTextNormal,
        ),
      ],
    );
  }
}
