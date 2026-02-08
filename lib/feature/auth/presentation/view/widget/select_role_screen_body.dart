import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/auth/presentation/manager/select_role/select_role_cubit.dart';
import 'package:raai/feature/auth/presentation/view/widget/custom_list_select_role.dart';

class SelectRoleScreenBody extends StatelessWidget {
  const SelectRoleScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SelectRoleCubit>();

    return Padding(
      padding: REdgeInsets.all(16),
      child: Column(
        children: [
          const RSizedBox(height: 64),
          Text(
            'حدد هويتك',
            textAlign: TextAlign.center,
            style: AppTextStyles.s24.w700.textNormal,
          ),
          const RSizedBox(height: 24),
          Text(
            'اختر الدور الذي تمثله في تطبيق راعي، لتبدأ رحلتك في المتابعة والرعاية الصحية الذكية.',
            textAlign: TextAlign.center,
            style: AppTextStyles.s16.w500.subTextNormal,
          ),
          const RSizedBox(height: 50),
          const CustomListSelectRole(),
          const RSizedBox(height: 40),
          AppButton.filled(
            text: 'تأكيد',
            onPressed: () {
              cubit.selectRole();
            },
          ),
          BlocListener<SelectRoleCubit, SelectRoleState>(
            listener: (context, state) {
              if (state is SelectRoleSuccess) {
                if (Navigator.of(context, rootNavigator: true).canPop()) {
                  Navigator.of(context, rootNavigator: true).pop();
                }

                showAnimatedTopSnackBar(
                  context,
                  message: 'تم حفظ البيانات بنجاح',
                  subMessage: 'كمّل الخطوة التالية',
                );
                if (state.entity.appCode == 325) {
                  context.push(AppRoutes.medicalInfo);
                }
                if (state.entity.appCode == 411) {
                  context.push(AppRoutes.camingSoon);
                }
              }
              if (state is SelectRoleFailure) {
                if (Navigator.of(context, rootNavigator: true).canPop()) {
                  Navigator.of(context, rootNavigator: true).pop();
                }

                showAnimatedTopSnackBar(
                  context,
                  isError: true,
                  message: 'في مشكلة',
                  subMessage: state.message,
                );
              }
              if (state is SelectRoleLoading) {
                AppConstant.showLoadingDialog(context);
              }
            },
            child: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
