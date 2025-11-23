import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';

class OnBoardingView3 extends StatelessWidget {
  const OnBoardingView3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RSizedBox(height: 60),
        Text(
          'أمانك أولوية.. في أي وقت!',
          style: AppTextStyles.s24.w700.textNormal,
        ),
        const RSizedBox(height: 24),
        Text(
          textAlign: TextAlign.center,
          'في حالة الطوارئ أو القراءات غير الطبيعية، سيتم إرسال تنبيه فوري لمقدم الرعاية ، أو يمكنك طلب المساعدة بضغطة زر واحدة.',
          style: AppTextStyles.s16.w500.subTextNormal,
        ),
        const RSizedBox(height: 50),
        Image.asset(
          AppImage.sos,
          width: 208.r,
          height: 208.r,
          fit: BoxFit.cover,
        ),
        const RSizedBox(height: 45),
        Text(
          'راعي معك خطوة بخطوة',
          style: AppTextStyles.s14.w400.subTextNormal,
        ),
      ],
    );
  }
}
