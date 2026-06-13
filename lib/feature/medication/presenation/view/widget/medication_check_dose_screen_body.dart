import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/app_text_field.dart';
import 'package:raai/core/widget/custom_app_bar_app.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/caregivers/presentation/view/widget/custom_show_qr_code.dart';
import 'package:raai/feature/medication/domain/entities/medication_reminder_entity.dart';
import 'package:raai/feature/medication/presenation/manager/medication_check_dose/medication_check_dose_cubit.dart';

class MedicationCheckDoseScreenBody extends StatelessWidget {
  const MedicationCheckDoseScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicationCheckDoseCubit>();
    final medication =
        GoRouterState.of(context).extra as MedicationReminderEntity;
    return SingleChildScrollView(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const RSizedBox(height: 55),
          const CustomAppBarApp(title: 'تأكيد الجرعه'),
          const RSizedBox(height: 36),
          Text(
            'قم بتصوير الشريط أو إدخال عدد الجرعات\nالمتبقيه لتأكيد الجرعه',
            style: AppTextStyles.s16.w500.textNormal,
            textAlign: TextAlign.center,
          ),
          const RSizedBox(height: 32),
          if (medication.form == 'TABLET')
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(230.r, 230.r),
                  painter: QRBorderPainter(),
                ),
                BlocBuilder<MedicationCheckDoseCubit, MedicationCheckDoseState>(
                  builder: (context, state) {
                    if (cubit.image != null) {
                      return Image.file(
                        File(cubit.image!),
                        width: 200.r,
                        height: 200.r,
                        fit: BoxFit.cover,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                InkWell(
                  onTap: () async {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                    if (image != null) {
                      cubit.updateImage(image.path);
                    }
                  },
                  borderRadius: BorderRadius.circular(24.r),
                  splashColor: AppColor.primaryDarkActive,
                  highlightColor: AppColor.primaryDarkActive,
                  child: Container(
                    padding: REdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xadF8F8F8),
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: AppColor.subtextLightHover,
                        width: 1.r,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          CupertinoIcons.photo_camera,
                          color: AppColor.primaryDarkActive,
                        ),
                        const RSizedBox(height: 4),
                        Text(
                          'اضغط للتصوير',
                          style: AppTextStyles.s14.w400.primaryDarkActive,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          const RSizedBox(height: 24),
          Text(
            'صور الشريط بوضوح للتأكيد',
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
          AppTextField(
            hint: '12',
            label: 'أدخل عدد الجرعات المتبقيه',
            padding: REdgeInsets.symmetric(horizontal: 32),
            controller: cubit.elderCodeController,
          ),
          const RSizedBox(height: 10),
          Text(
            'سيتم حساب الجرعات للتأكد اذا اخذت الجرعه',
            style: AppTextStyles.s12.w300.subTextNormal,
          ),
          const RSizedBox(height: 30),
          AppButton.filled(
            text: 'معالجه',
            onPressed: () {
              if (cubit.elderCodeController.text.isNotEmpty) {
                cubit.doNotRemember(
                  medication.id,
                  int.parse(cubit.elderCodeController.text),
                );
                return;
              }
              if (cubit.image == null) {
                showAnimatedTopSnackBar(
                  context,
                  message: 'في مشكلة',
                  subMessage: 'من فضلك التقط صوره',
                  isError: true,
                );
                return;
              }

              cubit.tabletModel(cubit.image);
            },
          ),
          BlocListener<MedicationCheckDoseCubit, MedicationCheckDoseState>(
            listener: (context, state) {
              if (state is MedicationCheckDoseFailure) {
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
              if (state is MedicationCheckDoseLoading) {
                AppConstant.showLoadingDialog(context);
              }
              if (state is MedicationCheckDoseModelSuccess) {
                cubit.doNotRemember(medication.id, state.data.pillCount!);
              }
              if (state is MedicationCheckDoseRememberSuccess) {
                if (context.canPop()) {
                  context.pop();
                }
                if (state.data.status == 'MISSED') {
                  showAnimatedTopSnackBar(
                    context,
                    message: 'نجحت',
                    subMessage: 'لم يتم اخذ الجرعة يجب اخذ الجرعة الان',
                  );
                }
                if (state.data.status == 'TAKEN') {
                  showAnimatedTopSnackBar(
                    context,
                    message: 'نجحت',
                    subMessage: 'تم اخذ الجرعة مش محتاح تاخد دواء الان',
                  );
                }
                if (state.data.status == 'EXTRA') {
                  showAnimatedTopSnackBar(
                    context,
                    message: 'نجحت',
                    subMessage: 'تم اخذ جرعات زيادة من العلاج لا تاخذ الان',
                  );
                }
                context.pop();
              }
            },
            child: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
