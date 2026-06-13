import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/core/widget/show_animated_top_snack_bar.dart';
import 'package:raai/feature/medication/data/model/medication_reminder_model.dart';
import 'package:raai/feature/medication/presenation/manager/medication_reminder/medication_reminder_cubit.dart';

class MedicationReminderScreenBody extends StatelessWidget {
  const MedicationReminderScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>;
    final data = MedicationReminderModel.fromJson(
      jsonDecode(extra['medication']) as Map<String, dynamic>,
    ).toEntity();
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const RSizedBox(height: 55),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  radius: 20,
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                  borderRadius: BorderRadius.circular(180),

                  child: Ink(
                    padding: REdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColor.disableLight,
                      borderRadius: BorderRadius.circular(180),
                    ),
                    child: Icon(Icons.close, color: AppColor.black, size: 28.r),
                  ),
                ),
              ),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColor.primaryLightHover,
                  borderRadius: BorderRadius.circular(180),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8.w,
                  children: [
                    SvgPicture.asset(
                      AppIcons.clock,
                      colorFilter: const ColorFilter.mode(
                        AppColor.primaryDark,
                        BlendMode.srcIn,
                      ),
                    ),
                    Text(
                      '${AppConstant.formatTime1(data.scheduledTime.toLocal())} ${AppConstant.getArabicPeriod(data.scheduledTime.toLocal())}',
                      style: AppTextStyles.s16.w500.primaryDark,
                    ),
                  ],
                ),
              ),
              const RSizedBox(width: 50),
            ],
          ),
          const RSizedBox(height: 32),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 275.r,
                height: 275.r,
                padding: REdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(180),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColor.shadowColor,
                      offset: Offset(0, 0),
                      blurRadius: 20,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(180),
                  child: data.image == null
                      ? Image.asset(
                          AppImage.medicinePlaceholder,
                          fit: BoxFit.cover,
                          height: 268.r,
                          width: 268.r,
                        )
                      : CachedNetworkImage(
                          imageUrl: data.image!,
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.error_outline,
                              color: AppColor.redNormal,
                            ),
                          ),
                          placeholder: (context, url) =>
                              ShimmerEffect(height: 268.r, width: 268.r),
                          height: 268.r,
                          width: 268.r,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 20,
                child: Container(
                  padding: REdgeInsets.fromLTRB(16, 4, 16, 4),
                  decoration: BoxDecoration(
                    color: AppColor.secondaryNormal,
                    borderRadius: BorderRadius.circular(180),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadowColor,
                        offset: Offset(0, 0),
                        blurRadius: 50,
                        spreadRadius: 0,
                      ),
                    ],
                    border: Border.all(width: 4.r, color: AppColor.white),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${data.pillsPerDose}',
                        style: AppTextStyles.s20.w600.white,
                      ),
                      Text('حبة', style: AppTextStyles.s12.w300.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const RSizedBox(height: 16),
          Text('وقت تناول الدواء', style: AppTextStyles.s28.w700.primaryNormal),
          const RSizedBox(height: 8),
          SizedBox(
            width: 231.w,
            child: Text(
              data.name,
              style: AppTextStyles.s20.w600.textNormal,
              textAlign: TextAlign.center,
            ),
          ),
          const RSizedBox(height: 32),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber, color: AppColor.subtextNormal),
              const RSizedBox(width: 8),
              Text(
                data.withFood == true
                    ? data.foodTiming == 'before'
                          ? 'يُفضل تناوله قبل الطعام'
                          : 'يُفضل تناوله بعد الطعام'
                    : 'يمكن تناوله دون طعام',
                style: AppTextStyles.s14.w400.subTextNormal,
              ),
            ],
          ),
          const RSizedBox(height: 32),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                context.read<MedicationReminderCubit>().takeMedication(
                  data.doseId,
                );
              },
              borderRadius: BorderRadius.circular(180),
              splashColor: AppColor.primaryNormalHover,
              child: Ink(
                padding: REdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(180),
                  gradient: const LinearGradient(
                    colors: [AppColor.primaryDark, AppColor.primaryNormal],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    const Icon(
                      Icons.check_circle_outline_outlined,
                      color: AppColor.white,
                    ),
                    Text(
                      'لقد تناولته الآن',
                      style: AppTextStyles.s20.w600.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const RSizedBox(height: 24),
          Row(
            spacing: 17.w,
            children: [
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      context.read<MedicationReminderCubit>().snoozeMedication(
                        data.doseId,
                      );
                    },
                    borderRadius: BorderRadius.circular(180),
                    splashColor: AppColor.disableLightHover,
                    child: Ink(
                      padding: REdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(180),
                        color: AppColor.disableLightActive,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          const Icon(
                            Icons.snooze_outlined,
                            color: AppColor.black,
                          ),
                          Text(
                            'غفوة 5 دقائق',
                            style: AppTextStyles.s14.w400.textNormal,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      context.push(
                        AppRoutes.medicationCheckDose,
                        extra: data,
                      );
                    },
                    borderRadius: BorderRadius.circular(180),
                    splashColor: AppColor.disableLightHover,
                    child: Ink(
                      padding: REdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(180),
                        color: AppColor.disableLightActive,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          const Icon(
                            Icons.warning_amber,
                            color: AppColor.black,
                          ),
                          Text(
                            'مش متذكر',
                            style: AppTextStyles.s14.w400.textNormal,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          BlocListener<MedicationReminderCubit, MedicationReminderState>(
            listener: (context, state) {
              if (state is MedicationReminderSuccess) {
                if (context.canPop()) {
                  context.pop();
                }
                showAnimatedTopSnackBar(
                  context,
                  message: 'نجحت',
                  subMessage: 'تم تسجيل انك اخدت الدواء',
                );
                context.pop();
              }
              if (state is MedicationReminderLoading) {
                AppConstant.showLoadingDialog(context);
              }
              if (state is MedicationReminderFailure) {
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
              if (state is MedicationReminderSnoozeSuccess) {
                if (context.canPop()) {
                  context.pop();
                }
                showAnimatedTopSnackBar(
                  context,
                  message: 'نجحت',
                  subMessage: 'تم تسجيل انك اخدت غفوه خمس دقائق لهذا الدواء',
                );
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
