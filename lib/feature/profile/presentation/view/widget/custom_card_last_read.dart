import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/profile/domain/entity/profile_user_entity.dart';
import 'package:raai/feature/profile/presentation/view/widget/custom_card_last_read_no_data.dart';

class CustomCardLastRead extends StatelessWidget {
  const CustomCardLastRead({
    super.key,
    required this.isBlood,
    required this.profile,
  });
  final bool isBlood;
  final ProfileUserEntity profile;

  @override
  Widget build(BuildContext context) {
    final sugar = profile.sugarProfile;
    final blood = profile.bloodProfile;

    if (isBlood && sugar == null) {
      return const CustomCardLastReadNoData(isBlood: true);
    }

    if (!isBlood && blood == null) {
      return const CustomCardLastReadNoData(isBlood: false);
    }
    return Container(
      padding: REdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: AppColor.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: isBlood,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppIcons.blood, width: 16.r, height: 16.r),
                const RSizedBox(width: 4),
                Text('اخر سكر', style: AppTextStyles.s14.w400.textNormal),
              ],
            ),
          ),
          Visibility(
            visible: !isBlood,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppIcons.heart, width: 16.r, height: 16.r),
                const RSizedBox(width: 4),
                Text('اخر ضغط', style: AppTextStyles.s14.w400.textNormal),
              ],
            ),
          ),
          const RSizedBox(height: 4),
          Visibility(
            visible: isBlood,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text('mg/dL ', style: AppTextStyles.s12.w300.textNormal),
                Text(
                  profile.sugarProfile!.valueMgDl.toString(),
                  style: AppTextStyles.s20.w600.redNormal,
                ),
              ],
            ),
          ),
          Visibility(
            visible: !isBlood,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  profile.bloodProfile?.dia.toString() ??'',
                  style: AppTextStyles.s20.w600.redNormal,
                ),
                Text('  /  ', style: AppTextStyles.s12.w300.textNormal),
                Text(
                  profile.bloodProfile?.sys.toString()??'',
                  style: AppTextStyles.s20.w600.redNormal,
                ),
              ],
            ),
          ),
          const RSizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 4.w,
            children: [
              Visibility(
                visible: isBlood,
                child: Text(
                  profile.sugarProfile?.status??'',
                  style: AppTextStyles.s12.w300.textNormal,
                ),
              ),
              Visibility(
                visible: !isBlood,
                child: Text(
                  profile.bloodProfile?.status??'',
                  style: AppTextStyles.s12.w300.textNormal,
                ),
              ),
              Visibility(
                visible: isBlood,
                child: Container(
                  width: 12.r,
                  height: 12.r,
                  decoration: ShapeDecoration(
                    color: profile.sugarProfile?.trafficColor,
                    shape: const OvalBorder(),
                  ),
                ),
              ),
              Visibility(
                visible: !isBlood,
                child: Container(
                  width: 12.r,
                  height: 12.r,
                  decoration: ShapeDecoration(
                    color: profile.bloodProfile?.trafficColor,
                    shape: const OvalBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
