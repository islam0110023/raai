import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/manager/bottom_nav_caregiver_cubit.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/view/home_caregiver_view.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/view/widget/custom_bottom_nav_bar_caregiver.dart';
import 'package:raai/feature/caregiver/profile_caregiver/presentation/view/profile_caregiver_view.dart';

class BottomNavBarCaregiver extends StatelessWidget {
  const BottomNavBarCaregiver({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BottomNavCaregiverCubit>();
    final state = context.watch<BottomNavCaregiverCubit>();
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: IndexedStack(
        index: state.currentIndex,
        children: const [
          HomeCaregiverView(),
          SizedBox(),
          ProfileCaregiverView(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBarCaregiver(
        controller: controller,
        state: state,
      ),
      floatingActionButton: state.currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                context.push(AppRoutes.connectElderCaregiver);
              },
              heroTag: 'add-elder',
              backgroundColor: AppColor.primaryNormal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(180),
              ),
              splashColor: AppColor.primaryNormalHover,
              child: Icon(
                CupertinoIcons.plus,
                color: AppColor.white,
                size: 21.r,
              ),
            )
          : null,
    );
  }
}
