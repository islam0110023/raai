import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/custom_app_bar_app.dart';
import 'package:raai/feature/caregivers/presentation/manager/caregiver_list/caregiver_list_cubit.dart';
import 'package:raai/feature/caregivers/presentation/view/widget/custom_list_caregiver_list.dart';

class CaregiversListScreenBody extends StatelessWidget {
  const CaregiversListScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<CaregiverListCubit>().getCaregiverList();
      },
      edgeOffset: 50,
      color: Platform.isAndroid ? AppColor.primaryNormal : null,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 16.r),

            sliver: SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const RSizedBox(height: 50),
                  const CustomAppBarApp(title: 'المرافقين'),
                  const RSizedBox(height: 32),
                  Text(
                    'يمكنك إدارة الأشخاص الذين يساعدونك في متابعة بياناتك الصحية',
                    style: AppTextStyles.s16.w500.subTextNormal,
                    textAlign: TextAlign.center,
                  ),
                  const RSizedBox(height: 32),
                  Container(
                    padding: REdgeInsets.symmetric(horizontal: 70, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColor.primaryNormal,
                        width: 1.r,
                      ),
                    ),
                    child: BlocBuilder<CaregiverListCubit, CaregiverListState>(
                      builder: (context, state) {
                        if (state is CaregiverListSuccess) {
                          return Text(
                            'لديك ${state.data.length} مرافقين',
                            style: AppTextStyles.s12.w300.textNormal,
                          );
                        }
                        return Text(
                          'لديك 0 مرافقين',
                          style: AppTextStyles.s12.w300.textNormal,
                        );
                      },
                    ),
                  ),
                  const RSizedBox(height: 24),
                ],
              ),
            ),
          ),
          const CustomListCaregiverList(),
        ],
      ),
    );
  }
}
