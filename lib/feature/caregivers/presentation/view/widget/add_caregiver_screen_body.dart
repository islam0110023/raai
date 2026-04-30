import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/custom_app_bar_app.dart';
import 'package:raai/feature/caregivers/presentation/view/widget/custom_show_qr_code.dart';
import 'package:share_plus/share_plus.dart';

class AddCaregiverScreenBody extends StatelessWidget {
  const AddCaregiverScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const RSizedBox(height: 50),
          const CustomAppBarApp(title: 'ربط مرافق'),
          const RSizedBox(height: 32),
          Text(
            'يمكنك دعوة مرافق لمساعدتك في متابعة بياناتك الصحية',
            style: AppTextStyles.s16.w500.subTextNormal,
            textAlign: TextAlign.center,
          ),
          const RSizedBox(height: 32),
          const CustomShowQrCode(),
          const RSizedBox(height: 16),
          SizedBox(
            width: 250.w,
            child: Text(
              'اطلب من المرافق مسح هذا الرمز من تطبيق المرافق',
              style: AppTextStyles.s16.w500.subTextNormal,
              textAlign: TextAlign.center,
            ),
          ),
          const RSizedBox(height: 24),
          Row(
            spacing: 9.5.w,
            children: [
              Expanded(
                child: Divider(color: AppColor.disableNormal, thickness: 1.r),
              ),
              Text('أو', style: AppTextStyles.s14.w400.subTextNormal),
              Expanded(
                child: Divider(color: AppColor.disableNormal, thickness: 1.r),
              ),
            ],
          ),
          const RSizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: Text('كود الرابط', style: AppTextStyles.s16.w500.textNormal),
          ),
          const RSizedBox(height: 8),
          Container(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: AppColor.subtextLightHover,
                width: 1.5.r,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('RAEY-7F92', style: AppTextStyles.s14.w400.subTextNormal),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(text: 'RAEY-7F92'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'تم النسخ',
                              style: AppTextStyles.s12.w400.white,
                            ),
                          ],
                        ),
                        backgroundColor: AppColor.black,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.symmetric(
                          horizontal: 140.r,
                          vertical: 80.r,
                        ),
                        padding: REdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        duration: const Duration(seconds: 2),
                        elevation: 0,
                      ),
                    );
                  },
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(AppIcons.editCopy),
                ),
              ],
            ),
          ),
          const RSizedBox(height: 8),
          Text(
            'يمكنك إضافة أو تغيير المرافق لاحقًا من الإعدادات',
            style: AppTextStyles.s12.w300.subTextNormal,
          ),
          const RSizedBox(height: 50),
          AppButton.filled(
            text: 'المشاركه',
            onPressed: () {
              SharePlus.instance.share(
                ShareParams(text: 'RAEY-7F92', subject: 'RAEY-7F92'),
              );
            },
          ),
        ],
      ),
    );
  }
}
