import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/app_text_field.dart';
import 'package:raai/core/widget/custom_app_bar_app.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/caregiver/connect_elder_caregiver/presentation/manager/connect_elder_caregiver/connect_elder_caregiver_cubit.dart';
import 'package:raai/feature/caregiver/connect_elder_caregiver/presentation/view/widget/custom_scan_q_r_code.dart';

class ConnectElderCaregiverScreenBody extends StatelessWidget {
  const ConnectElderCaregiverScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const RSizedBox(height: 55),
          const CustomAppBarApp(title: 'ربط مسن'),
          const RSizedBox(height: 32),
          Text(
            'قم بمسح رمز المسن أو إدخال كود الربط\nلإرسال طلب المتابعة الصحية',
            style: AppTextStyles.s16.w500.subTextNormal,
            textAlign: TextAlign.center,
          ),
          const RSizedBox(height: 32),
          const CustomScanQRCode(),
          const RSizedBox(height: 32),
          Text(
            'امسح رمز QR من تطبيق المسن',
            style: AppTextStyles.s16.w500.subTextNormal,
          ),
          const RSizedBox(height: 44),
          Row(
            spacing: 9.5.w,
            children: [
              Expanded(
                child: Divider(color: AppColor.disableNormal, thickness: 1.r),
              ),
              Text('أو', style: AppTextStyles.s14.w400.subTextNormal),
              Expanded(
                child: Divider(color: AppColor.disableNormal, thickness: 1.r),
              ),
            ],
          ),
          const RSizedBox(height: 24),
          BlocBuilder<ConnectElderCaregiverCubit, ConnectElderCaregiverState>(
            builder: (context, state) {
              final cubit = context.read<ConnectElderCaregiverCubit>();
              return AppTextField(
                hint: 'سيظهر الكود بعد المسح',
                label: 'أدخل كود المسن',
                padding: REdgeInsets.symmetric(horizontal: 32),
                controller: cubit.elderCodeController,
              );
            },
          ),
          const RSizedBox(height: 10),
          Text(
            'سيتم إرسال طلب رعاية للمسن بعد التحقق',
            style: AppTextStyles.s12.w300.subTextNormal,
          ),
          const RSizedBox(height: 30),
          Hero(
            tag: 'add-elder',
            child: AppButton.filled(
              text: 'طلب المتابعة',
              onPressed: () {
                context
                    .read<ConnectElderCaregiverCubit>()
                    .connectCaregiverWithElder();
              },
            ),
          ),
          BlocListener<ConnectElderCaregiverCubit, ConnectElderCaregiverState>(
            listener: (context, state) {
              if (state is ConnectElderCaregiverLoading) {
                AppConstant.showLoadingDialog(context);
              }
              if (state is ConnectElderCaregiverSuccess) {
                if (context.canPop()) {
                  context.pop();
                }
                showAnimatedTopSnackBar(
                  context,
                  message: 'نجحت',
                  subMessage: 'تم ارسال طلب الربط بنجاح',
                );
              }
              if (state is ConnectElderCaregiverFailure) {
                if (context.canPop()) {
                  context.pop();
                }
                showAnimatedTopSnackBar(
                  context,
                  message: 'في مشكلة',
                  subMessage: state.message,
                  isError: true,
                );
              }
            },
            child: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
