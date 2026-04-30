import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button_back.dart';

class CustomUpperHomeView extends StatelessWidget {
  const CustomUpperHomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(AppImage.avatarFemale),
      contentPadding: EdgeInsets.zero,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'صباح الخير يا',
              style: AppTextStyles.s20.w600.textNormal,
            ),
            TextSpan(
              text: ' اسعاد',
              style: AppTextStyles.s20.w600.secondaryDarkHover,
            ),
          ],
        ),
      ),
      trailing: AppButtonBack(
        onPressed: () {
          context.push(AppRoutes.notificationScreen);
        },
        isLabel: false,
        icon: AppIcons.alertAlarm,
      ),
    );
  }
}
