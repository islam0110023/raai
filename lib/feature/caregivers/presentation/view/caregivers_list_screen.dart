import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/feature/caregivers/presentation/view/widget/caregivers_list_screen_body.dart';

class CaregiversListScreen extends StatelessWidget {
  const CaregiversListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CaregiversListScreenBody(),
      bottomNavigationBar: Padding(
        padding: REdgeInsets.fromLTRB(16, 0, 16, 40),
        child: AppButton.filled(
          text: 'ربط مرافق جديد',
          onPressed: () {
            context.push(AppRoutes.addCaregiver);
          },
        ),
      ),
    );
  }
}
