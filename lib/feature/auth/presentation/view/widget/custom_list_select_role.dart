import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/feature/auth/presentation/manager/select_role/select_role_cubit.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_select_role.dart';

class CustomListSelectRole extends StatelessWidget {
  const CustomListSelectRole({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SelectRoleCubit>();
    final state = context.watch<SelectRoleCubit>();

    return Padding(
      padding: REdgeInsets.all(16),
      child: Row(
        spacing: 102.w,
        children: [
          Expanded(
            child: CustomSelectRole(
              value: !state.isRole,
              image: AppImage.son,
              title: 'مرافق',
              onTap: () {
                cubit.selectIsRole(false);
              },
              onChanged: (value) {
                cubit.selectIsRole(false);
              },
            ),
          ),
          Expanded(
            child: CustomSelectRole(
              value: state.isRole,
              image: AppImage.father,
              title: 'مستخدم',
              onTap: () {
                cubit.selectIsRole(true);
              },
              onChanged: (value) {
                cubit.selectIsRole(true);
              },
            ),
          ),
        ],
      ),
    );
  }
}
