import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/app_text_field.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/reads/presentation/manager/blood/blood_cubit.dart';

class CustomAlertDialogBlood extends StatelessWidget {
  const CustomAlertDialogBlood({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final bloodCubit = context.read<BloodCubit>();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: REdgeInsets.symmetric(horizontal: 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.white.withAlpha(20)),
          ),
          Container(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
            margin: REdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColor.disableLightActive,
                width: 1.r,
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColor.shadowColor,
                  blurRadius: 12,
                  offset: Offset(0, 0),
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppImage.pen1, width: 64.r, height: 64.r),
                const RSizedBox(height: 8),
                Text('تعديل القياس', style: AppTextStyles.s16.w500.textNormal),
                const RSizedBox(height: 16),
                Row(
                  spacing: 8.w,
                  children: [
                    Expanded(
                      child: AppTextField(
                        hint: 'الضغط الانبساطي',
                        textAlign: TextAlign.center,
                        controller: bloodCubit.diastolicController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        keyboardType: TextInputType.number,
                        padding: REdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 12,
                        ),
                      ),
                    ),
                    Text('/', style: AppTextStyles.s24.w700.black),
                    Expanded(
                      child: AppTextField(
                        hint: 'الضغط الانقباضي',
                        textAlign: TextAlign.center,
                        controller: bloodCubit.systolicController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        keyboardType: TextInputType.number,
                        padding: REdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const RSizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(AppIcons.alert),
                    const RSizedBox(width: 10),
                    Text(
                      'القراءة الطبيعية غالبًا 80 / 120',
                      style: AppTextStyles.s16.w500.subTextNormal,
                    ),
                  ],
                ),
                const RSizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: AppButton.filled(
                        text: 'حفظ',
                        onPressed: () {
                          bloodCubit.updateBlood(id: id);
                        },
                        textStyle: AppTextStyles.s14.w400.white,
                      ),
                    ),
                    const RSizedBox(width: 8),
                    Expanded(
                      child: AppButton.outline(
                        text: 'الغاء',
                        onPressed: () {
                          context.pop();
                        },
                        textStyle: AppTextStyles.s14.w400.primaryNormal,
                      ),
                    ),
                  ],
                ),
                BlocListener<BloodCubit, BloodState>(
                  listener: (context, state) {
                    if (state is BloodSuccess) {
                      if (Navigator.of(context, rootNavigator: true).canPop()) {
                        Navigator.of(context, rootNavigator: true).pop();
                      }
                      showAnimatedTopSnackBar(
                        context,
                        message: 'العملية نجحت',
                        subMessage: 'تم تحديث البيانات بنجاح',
                      );
                      bloodCubit.getBloodReads();
                      context.pop();
                    }
                    if (state is BloodFailure) {
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
                    if (state is BloodLoading) {
                      AppConstant.showLoadingDialog(context);
                    }
                  },
                  child: const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
