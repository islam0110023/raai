import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button_back.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/manager/home_caregiver/home_caregiver_cubit.dart';

class CustomUpperHomeCaregiver extends StatelessWidget {
  const CustomUpperHomeCaregiver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCaregiverCubit, HomeCaregiverState>(
      builder: (context, state) {
        if (state is HomeCaregiverSuccess) {
          return ListTile(
            leading: Image.asset(
              state.data.gender == 'MALE'
                  ? AppImage.avatarMale
                  : AppImage.avatarFemale,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(AppImage.avatarFemale);
              },
            ),
            contentPadding: EdgeInsets.zero,
            subtitle: Text(
              state.data.name,
              style: AppTextStyles.s16.w500.primaryNormal,
            ),
            title: RichText(
              text: TextSpan(
                children: [
                  DateTime.now().hour < 12
                      ? TextSpan(
                          text: 'صباح الخير يا',
                          style: AppTextStyles.s16.w500.textNormal,
                        )
                      : TextSpan(
                          text: 'مساء الخير يا',
                          style: AppTextStyles.s16.w500.textNormal,
                        ),
                  // TextSpan(
                  //   text: ,
                  //   style: AppTextStyles.s20.w600.secondaryDarkHover,
                  // ),
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
        if (state is HomeCaregiverLoading) {
          return const ShimmerEffect(width: double.infinity, height: 60);
        }
        return const SizedBox();
      },
    );
  }
}
