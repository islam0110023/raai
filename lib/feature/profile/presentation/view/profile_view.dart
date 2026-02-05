import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppButton.filled(
            text: 'تسجيل الخروج',
            onPressed: () {
              getIt<AuthCubit>().logout();
            },
          ),
        ],
      ),
    );
  }
}
