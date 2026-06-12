import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:raai/feature/caregiver/profile_caregiver/presentation/manager/profile_caregiver/profile_caregiver_cubit.dart';
import 'package:raai/feature/caregiver/profile_caregiver/presentation/view/widget/custom_profile_caregiver_upper.dart';
import 'package:raai/feature/profile/data/model/items_profile_model.dart';
import 'package:raai/feature/profile/presentation/view/widget/custom_card_items_profile.dart';

class ProfileCaregiverViewBody extends StatelessWidget {
  const ProfileCaregiverViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<ProfileCaregiverCubit>().getProfileCaregiverData();
      },
      edgeOffset: 50,
      color: Platform.isAndroid ? AppColor.primaryNormal : null,
      child: ListView(
        padding: REdgeInsets.symmetric(horizontal: 16),
        children: [
          const CustomProfileCaregiverUpper(),
          CustomCardItemsProfile(
            title: 'الاعدادات',
            items: [
              ItemsProfileModel(
                icon: AppIcons.editing,
                title: 'تعديل الملف الشخصي',
                index: 1,
              ),
              ItemsProfileModel(
                icon: AppIcons.notification,
                title: 'الاشعارات و التنبيهات',
                onTap: () {
                  context.push(AppRoutes.notificationScreen);
                },
              ),
              ItemsProfileModel(icon: AppIcons.mail, title: 'اللغه و التفاعل'),
              ItemsProfileModel(
                icon: AppIcons.padLock,
                title: 'الخصوصيه و الامان',
                index: 2,
              ),
            ],
          ),
          const RSizedBox(height: 24),
          CustomCardItemsProfile(
            title: 'أخر',
            items: [
              ItemsProfileModel(
                icon: AppIcons.logout,
                title: 'تسجيل الخروج',
                index: 3,
                onTap: () {
                  getIt<AuthCubit>().logout();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
