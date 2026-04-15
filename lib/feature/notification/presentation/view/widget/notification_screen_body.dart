import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/swipe_to_delete_wrapper.dart';
import 'package:raai/feature/notification/presentation/view/widget/custom_card_notification.dart';
import 'package:raai/feature/notification/presentation/view/widget/custom_card_request_notification.dart';
import 'package:raai/feature/notification/presentation/view/widget/custom_upper_notification.dart';

class NotificationScreenBody extends StatelessWidget {
  const NotificationScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomUpperNotification(),
        Positioned(
          top: 130.h,
          left: 16.w,
          right: 16.w,
          child: Column(
            children: [
              Container(
                padding: REdgeInsets.symmetric(horizontal: 60, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColor.primaryNormal, width: 2.r),
                ),
                child: Text(
                  'لديك 3 إشعارات جديدة',
                  style: AppTextStyles.s12.w300.textNormal,
                ),
              ),
              const RSizedBox(height: 16),
              SwipeToDeleteWrapper(
                onDelete: () {},
                child: const CustomCardNotification(
                  icon: AppIcons.panadolIcon,
                  title1: 'بانادول',
                  title2: 'موعد اخذ الدواء',
                  subtitle: 'دواء',
                  date: 'الان',
                ),
              ),
              const Divider(height: 16, color: AppColor.textLight),
              SwipeToDeleteWrapper(
                onDelete: () {},
                child: const CustomCardNotification(
                  icon: AppIcons.reportIcon,
                  title1: 'السكر',
                  title2: 'موعد تقريرك الشهري',
                  subtitle: 'تقارير',
                  date: 'منذ دقيقه',
                ),
              ),
              const Divider(height: 16, color: AppColor.textLight),
              SwipeToDeleteWrapper(
                onDelete: () {},
                child: const CustomCardNotification(
                  icon: AppIcons.bloodNotIcon,
                  title1: 'الضغط',
                  title2: 'موعد ادخال قياسك',
                  subtitle: 'قياس',
                  date: 'منذ دقيقه',
                  isRead: true,
                ),
              ),
              const Divider(height: 16, color: AppColor.textLight),
              CustomCardRequestNotification(
                title1: 'الحج متولي',
                title2: 'أرسل اليك طلب رعايه',
                subtitle: 'مرافق',
                date: 'منذ دقيقه',
                onAccept: () {},
                onReject: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
