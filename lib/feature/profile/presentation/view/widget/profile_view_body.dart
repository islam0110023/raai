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
import 'package:raai/feature/profile/data/model/items_profile_model.dart';
import 'package:raai/feature/profile/presentation/manager/profile/profile_cubit.dart';
import 'package:raai/feature/profile/presentation/view/widget/custom_card_items_profile.dart';
import 'package:raai/feature/profile/presentation/view/widget/custom_upper_profile.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<ProfileCubit>().getUserProfile();
      },
      edgeOffset: 50,
      color: Platform.isAndroid ? AppColor.primaryNormal : null,
      child: ListView(
        padding: REdgeInsets.symmetric(horizontal: 16),
        children: [
          const CustomUpperProfile(),
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
              ),
              ItemsProfileModel(icon: AppIcons.mail, title: 'اللغه و التفاعل'),
              ItemsProfileModel(
                icon: AppIcons.padLock,
                title: 'الخصوصيه و الامان',
                index: 2,
              ),
            ],
          ),
          const RSizedBox(height: 16),
          CustomCardItemsProfile(
            title: 'الصحة',
            items: [
              ItemsProfileModel(
                icon: AppIcons.multipleUser,
                title: 'المرافقيين',
                index: 1,
              ),
              ItemsProfileModel(
                icon: AppIcons.records,
                title: 'السجلات الصحيه',
              ),
              ItemsProfileModel(
                icon: AppIcons.medicalRate,
                title: 'الفحص الطبي',
                index: 2,
                onTap: () {
                  context.push(AppRoutes.selectModels);
                },
              ),
            ],
          ),
          const RSizedBox(height: 16),
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
          const RSizedBox(height: 120),
        ],
      ),
    );
  }
}
