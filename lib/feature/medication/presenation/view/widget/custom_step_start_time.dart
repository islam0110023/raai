import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/feature/medication/data/model/input_medication_model.dart';
import 'package:raai/feature/medication/presenation/manager/medication_form_cubit.dart';

class CustomStepStartTime extends StatelessWidget {
  const CustomStepStartTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: REdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: BoxBorder.all(
              color: AppColor.primaryLightActive,
              width: 2.r,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColor.shadowColor,
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: BlocBuilder<MedicationFormCubit, InputMedicationModel>(
            builder: (context, state) {
              final time = state.startTime ?? '07:00';
              return Row(
                children: [
                  SvgPicture.asset(AppIcons.clock, width: 25.r, height: 25.r),
                  const RSizedBox(width: 24),
                  Text(
                    AppConstant.formatTime(time),
                    style: AppTextStyles.s20.w600.primaryNormal,
                  ),
                  const RSizedBox(width: 8),
                  Container(
                    padding: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColor.primaryLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      AppConstant.getPeriod(time),
                      style: AppTextStyles.s14.w400.subTextNormal,
                    ),
                  ),
                  const Spacer(),
                  AppButton.filled(
                    text: 'تغيير',
                    onPressed: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 7, minute: 0),
                      );

                      if (pickedTime != null && context.mounted) {
                        context.read<MedicationFormCubit>().updateStartTime(
                          '${pickedTime.hour.toString().padLeft(2, '0')}:'
                          '${pickedTime.minute.toString().padLeft(2, '0')}',
                        );
                      }
                    },
                    isOutlineColor: false,
                    padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: AppTextStyles.s14.w700.white,
                    radius: 100,
                    width: 70.w,
                  ),
                ],
              );
            },
          ),
        ),
        if (context.watch<MedicationFormCubit>().state.repeatType == 'DAILY')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const RSizedBox(height: 8),
              Text('جدول مواعيدك:', style: AppTextStyles.s16.w500.textNormal),
              const RSizedBox(height: 8),
              BlocBuilder<MedicationFormCubit, InputMedicationModel>(
                builder: (context, state) {
                  if (state.startTime == null || state.dosesPerDay == null) {
                    return const SizedBox();
                  }

                  final times = AppConstant.generateMedicationTimes(
                    startTime: state.startTime!,
                    dosesPerDay: state.dosesPerDay!,
                  );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      times.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '• المعاد ${index + 1}: ${AppConstant.formatArabicTime(times[index])}',
                          style: AppTextStyles.s14.w400.subTextNormal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
      ],
    );
  }
}
