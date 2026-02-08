import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';

class LoadingModelView extends StatelessWidget {
  const LoadingModelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RSizedBox(height: 100),
        Text(
          'نحلل قراءاتك الصحية الآن',
          style: AppTextStyles.s24.w700.textNormal,
        ),
        const RSizedBox(height: 16),
        Lottie.asset(AppImage.loading),
        const RSizedBox(height: 32),
        DefaultTextStyle(
          style: AppTextStyles.s24.w700.primaryNormal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('جاري الفحص'),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    '....',
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                repeatForever: true,
              ),
            ],
          ),
        ),
        const RSizedBox(height: 120),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(AppImage.clockLottie, width: 44.r, height: 44.r),
            Text(
              'قد يستغرق الأمر لحظات',
              style: AppTextStyles.s12.w300.subTextNormal,
            ),
          ],
        ),
      ],
    );
  }
}
