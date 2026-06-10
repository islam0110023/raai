import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button_back.dart';
import 'package:raai/feature/profile/presentation/manager/profile/profile_cubit.dart';

class CustomUpperHomeView extends StatelessWidget {
  const CustomUpperHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>();

    return ListTile(
      leading: Image.asset(
        state.profileUserEntity?.personalData.gender == 'MALE'
            ? AppImage.avatarMale
            : AppImage.avatarFemale,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(AppImage.avatarFemale);
        },
      ),
      contentPadding: EdgeInsets.zero,
      title: RichText(
        text: TextSpan(
          children: [
            DateTime.now().hour < 12
                ? TextSpan(
                    text: 'صباح الخير يا',
                    style: AppTextStyles.s20.w600.textNormal,
                  )
                : TextSpan(
                    text: 'مساء الخير يا',
                    style: AppTextStyles.s20.w600.textNormal,
                  ),
            TextSpan(
              text: ' ${state.profileUserEntity?.personalData.firstName ?? ''}',
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
