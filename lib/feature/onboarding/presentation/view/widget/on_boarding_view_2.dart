import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';

class OnBoardingView2 extends StatelessWidget {
  const OnBoardingView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RSizedBox(height: 60),
        Text(
          'مواعيد دواك.. في أمان!',
          style: AppTextStyles.s24.w700.textNormal,
        ),
        const RSizedBox(height: 24),
        Text(
          textAlign: TextAlign.center,
          'راعي بيفكرك بمواعيد الأدوية بالضبط ، وبيسجل قياسات السكر والضغط بكل سهولة  عشان صحتك تكون متراقبة بدقة.',
          style: AppTextStyles.s16.w500.subTextNormal,
        ),
        const RSizedBox(height: 50),
        Image.asset(
          AppImage.clocking,
          width: 208.r,
          height: 208.r,
          fit: BoxFit.cover,
        ),
        const RSizedBox(height: 45),
        Text(
          'لا تفوت أي جرعة',
          style: AppTextStyles.s14.w400.subTextNormal,
        ),
      ],
    );
  }
}
