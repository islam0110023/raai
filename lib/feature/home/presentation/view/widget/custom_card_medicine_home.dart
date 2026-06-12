import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/home/presentation/manager/home_data/home_data_cubit.dart';
import 'package:raai/feature/home/presentation/view/widget/remaining_time_widget.dart';

class CustomCardMedicineHome extends StatelessWidget {
  const CustomCardMedicineHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDataCubit, HomeDataState>(
      builder: (context, state) {
        if (state is HomeDataSuccess) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: const [
                BoxShadow(
                  color: AppColor.shadowColor,
                  offset: Offset(0, 0),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      state.homeData.medicationImage == null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.asset(
                                AppImage.medicinePlaceholder,
                                fit: BoxFit.cover,
                                height: 134.h,
                                width: 149.w,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: CachedNetworkImage(
                                imageUrl: state.homeData.medicationImage!,
                                errorWidget: (context, url, error) =>
                                    const Center(
                                      child: Icon(
                                        Icons.error_outline,
                                        color: AppColor.redNormal,
                                      ),
                                    ),
                                placeholder: (context, url) =>
                                    // Theme.of(context).platform == TargetPlatform.iOS
                                    // ? const Center(child: CupertinoActivityIndicator())
                                    // : const Center(
                                    //     child: CircularProgressIndicator(
                                    //       color: AppColor.primaryNormal,
                                    //     ),
                                    //   ),
                                    ShimmerEffect(
                                      width: double.infinity,
                                      height: 128.h,
                                    ),
                                height: 134.h,
                                width: 149.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                      const RSizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                state.homeData.medicationName ?? '',
                                style: AppTextStyles.s14.w400.textNormal,
                              ),
                            ),
                            const RSizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${state.homeData.pillsPerDose} ',
                                    style: AppTextStyles
                                        .s14
                                        .w400
                                        .secondaryDarkHover,
                                  ),
                                  TextSpan(
                                    text: state.homeData.form,
                                    style: AppTextStyles.s14.w400.textNormal,
                                  ),
                                ],
                              ),
                            ),
                            const RSizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: state.homeData.medicationTime,
                                    style: AppTextStyles
                                        .s14
                                        .w400
                                        .secondaryDarkHover,
                                  ),
                                  TextSpan(
                                    text: ' | ',
                                    style: AppTextStyles.s14.w400.subTextNormal,
                                  ),
                                  TextSpan(
                                    text: state.homeData.medicationPeriod,
                                    style: AppTextStyles.s14.w400.textNormal,
                                  ),
                                ],
                              ),
                            ),
                            const RSizedBox(height: 15),
                            AppButton.filled(
                              text: 'ليس بعد',
                              isOutlineColor: false,
                              textStyle:
                                  AppTextStyles.s14.w400.secondaryLightHover,
                              padding: REdgeInsets.all(8),
                              onPressed: null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.primaryNormal,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24.r),
                      bottomLeft: Radius.circular(24.r),
                    ),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Text(
                      //   state.homeData.medicationTimeDifference ?? '',
                      //   style: AppTextStyles.s14.w400.white,
                      // ),
                      RemainingTimeWidget(
                        medicationDate: state.homeData.medicationTimeDifference,
                      ),
                      const RSizedBox(width: 5),
                      Icon(
                        CupertinoIcons.clock,
                        color: AppColor.white,
                        size: 14.r,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
