import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';
import 'package:raai/feature/reads/domain/entity/blood_read_entity.dart';
import 'package:raai/feature/reads/domain/entity/sugar_read_entity.dart';

class CustomCardOfReads extends StatelessWidget {
  const CustomCardOfReads({
    super.key,
    this.isToday = false,
    this.isBlood = false,
    this.onPressed,
    this.sugarReadEntity,
    this.bloodReadEntity,
  });
  final bool isToday;
  final bool isBlood;
  final SugarReadEntity? sugarReadEntity;
  final BloodReadEntity? bloodReadEntity;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isToday
          ? REdgeInsets.all(8)
          : REdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
      child: ClipRect(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: isBlood,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8.w,
                children: [
                  Text('سكر الدم', style: AppTextStyles.s16.w500.textNormal),
                  const RSizedBox(width: 4),
                  SvgPicture.asset(AppIcons.blood),
                ],
              ),
            ),
            Visibility(
              visible: !isBlood,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8.w,
                children: [
                  Text('ضفظ الدم', style: AppTextStyles.s16.w500.textNormal),
                  const RSizedBox(width: 4),
                  SvgPicture.asset(AppIcons.heart),
                ],
              ),
            ),
            const RSizedBox(height: 12),
            Visibility(
              visible: isBlood,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text('mg/dL ', style: AppTextStyles.s16.w500.textNormal),
                  Text(
                    sugarReadEntity?.valueMgDl.toString() ?? '',
                    style: AppTextStyles.s28.w700.redNormal,
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
                    bloodReadEntity?.dia.toString() ?? '',
                    style: AppTextStyles.s28.w700.redNormal,
                  ),
                  Text('  /  ', style: AppTextStyles.s16.w500.textNormal),
                  Text(
                    bloodReadEntity?.sys.toString() ?? '',
                    style: AppTextStyles.s28.w700.redNormal,
                  ),
                ],
              ),
            ),
            const RSizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.w,
              children: [
                Visibility(
                  visible: isBlood,
                  child: Text(
                    sugarReadEntity?.status ?? '',
                    style: AppTextStyles.s16.w500.textNormal,
                  ),
                ),
                Visibility(
                  visible: !isBlood,
                  child: Text(
                    bloodReadEntity?.status ?? '',
                    style: AppTextStyles.s16.w500.textNormal,
                  ),
                ),
                Visibility(
                  visible: isBlood,
                  child: Container(
                    width: 16.r,
                    height: 16.r,
                    decoration: ShapeDecoration(
                      color: sugarReadEntity?.trafficColor,
                      shape: const OvalBorder(),
                    ),
                  ),
                ),
                Visibility(
                  visible: !isBlood,
                  child: Container(
                    width: 16.r,
                    height: 16.r,
                    decoration: ShapeDecoration(
                      color: bloodReadEntity?.trafficColor,
                      shape: const OvalBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const RSizedBox(height: 12),
            ClipRect(
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.clock,
                    color: AppColor.primaryNormal,
                    size: 16.r,
                  ),
                  const RSizedBox(width: 4),

                  Visibility(
                    visible: isBlood,
                    child: Expanded(
                      child: Text(
                        sugarReadEntity?.recordedAt ?? '',
                        style: AppTextStyles.s12.w300.subTextNormal,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !isBlood,
                    child: Expanded(
                      child: Text(
                        bloodReadEntity?.recordedAt ?? '',
                        style: AppTextStyles.s12.w300.subTextNormal,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(visible: isToday, child: const RSizedBox(height: 8)),
            Visibility(
              visible: isToday,
              child: AppButton.filled(
                text: 'تعديل',
                onPressed: onPressed,
                width: 148.w,
                padding: REdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: AppTextStyles.s12.w300.white,
                size: Size(148.w, 36.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
