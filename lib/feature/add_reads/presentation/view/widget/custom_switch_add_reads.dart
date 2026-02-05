import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/add_reads/presentation/manager/add_reads_cubit.dart';

class CustomSwitchAddReads extends StatelessWidget {
  const CustomSwitchAddReads({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AddReadsCubit>();
    final state = context.watch<AddReadsCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            controller.changeIsBlood(true);
          },
          borderRadius: BorderRadius.circular(45.r),
          radius: 100.r,
          splashColor: AppColor.primaryLightHover,
          child: Container(
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45.r),
              border: Border.all(
                color: state.state.isBlood
                    ? AppColor.primaryNormal
                    : AppColor.disableNormal,
                width: 3.r,
              ),
            ),

            child: Row(
              children: [
                Text('ضغط سكر', style: AppTextStyles.s16.w500.textNormal),
                const RSizedBox(width: 4),
                SvgPicture.asset(
                  AppIcons.blood,
                  colorFilter: ColorFilter.mode(
                    state.state.isBlood ? AppColor.redNormal : AppColor.black,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            controller.changeIsBlood(false);
          },
          borderRadius: BorderRadius.circular(45.r),
          radius: 100.r,
          splashColor: AppColor.primaryLightHover,
          child: Container(
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45.r),
              border: Border.all(
                color: !state.state.isBlood
                    ? AppColor.primaryNormal
                    : AppColor.disableNormal,
                width: 3.r,
              ),
            ),

            child: Row(
              children: [
                Text('ضغط دم', style: AppTextStyles.s16.w500.textNormal),
                const RSizedBox(width: 4),
                SvgPicture.asset(
                  AppIcons.heart,
                  colorFilter: ColorFilter.mode(
                    !state.state.isBlood ? AppColor.redNormal : AppColor.black,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
