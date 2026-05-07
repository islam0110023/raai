import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';

class CustomLayoutInHomeView extends StatelessWidget {
  const CustomLayoutInHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return Stack(
          children: [
            Column(
              spacing: 16.h,
              children: [
                Row(
                  spacing: 16.w,
                  children: [
                    Expanded(
                      child: AppButton.outline(
                        text: 'تسجيل دواء',
                        isOutlineColor: false,
                        borderWidth: 1.r,
                        radius: 24,
                        padding: REdgeInsets.all(16),
                        textColor: AppColor.secondaryNormalHover,
                        widget: Row(
                          spacing: 8.w,
                          children: [
                            SvgPicture.asset(
                              AppIcons.medicine,
                              colorFilter: const ColorFilter.mode(
                                AppColor.secondaryDarkHover,
                                BlendMode.srcIn,
                              ),
                            ),
                            Text(
                              'تسجيل دواء',
                              style: AppTextStyles.s14.w400.textNormal,
                            ),
                          ],
                        ),
                        isWidget: true,
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: AppButton.outline(
                        text: 'ادخال قياس',
                        isOutlineColor: false,
                        borderWidth: 1.r,
                        radius: 24,
                        textColor: AppColor.secondaryNormalHover,
                        padding: REdgeInsets.all(16),
                        widget: Row(
                          spacing: 8.w,
                          children: [
                            SvgPicture.asset(
                              AppIcons.medical,
                              colorFilter: const ColorFilter.mode(
                                AppColor.secondaryDarkHover,
                                BlendMode.srcIn,
                              ),
                            ),
                            Text(
                              'ادخال قياس',
                              style: AppTextStyles.s14.w400.textNormal,
                            ),
                          ],
                        ),
                        isWidget: true,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 16.w,
                  children: [
                    Expanded(
                      child: AppButton.outline(
                        text: 'عمل فحص',
                        isOutlineColor: false,
                        borderWidth: 1.r,
                        radius: 24,
                        textColor: AppColor.secondaryNormalHover,

                        padding: REdgeInsets.all(16),
                        widget: Row(
                          spacing: 8.w,
                          children: [
                            SvgPicture.asset(
                              AppIcons.bloodNotIcon,
                              colorFilter: const ColorFilter.mode(
                                AppColor.secondaryDarkHover,
                                BlendMode.srcIn,
                              ),
                            ),
                            Text(
                              'عمل فحص',
                              style: AppTextStyles.s14.w400.textNormal,
                            ),
                          ],
                        ),
                        isWidget: true,
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: AppButton.outline(
                        text: 'اضافه مرافق',
                        isOutlineColor: false,
                        borderWidth: 1.r,
                        radius: 24,
                        textColor: AppColor.secondaryNormalHover,

                        padding: REdgeInsets.all(16),
                        widget: Row(
                          spacing: 8.w,
                          children: [
                            SvgPicture.asset(
                              AppIcons.multipleUser,
                              colorFilter: const ColorFilter.mode(
                                AppColor.secondaryDarkHover,
                                BlendMode.srcIn,
                              ),
                            ),
                            Text(
                              'اضافه مرافق',
                              style: AppTextStyles.s14.w400.textNormal,
                            ),
                          ],
                        ),
                        isWidget: true,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              left: width / 2,
              top: 10,
              bottom: 10,
              child: VerticalDivider(
                thickness: 1.w,
                color: AppColor.disableLightHover,
                width: 0,
              ),
            ),

            Positioned(
              top: 63.h,
              left: 10,
              right: 10,
              child: Divider(
                thickness: 1.h,
                color: AppColor.disableLightHover,
                height: 0,
              ),
            ),
          ],
        );
      },
    );
  }
}
