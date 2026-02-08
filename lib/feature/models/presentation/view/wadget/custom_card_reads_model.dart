import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/models/domain/entity/sugar_last_reading_entity.dart';

class CustomCardReadsModel extends StatelessWidget {
  const CustomCardReadsModel({
    super.key,
    required this.title,
    required this.items,
    this.isDaily = true,
  });
  final String title;
  final bool isDaily;
  final List<SugarLastReadingEntity> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: REdgeInsets.symmetric(horizontal: 16),
      padding: REdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTextStyles.s16.w500.textNormal),
          const RSizedBox(height: 10),
          ...List.generate(items.length, (index) {
            final item = items[index];
            return Container(
              padding: REdgeInsets.all(8),
              margin: index == items.length - 1
                  ? null
                  : REdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                borderRadius: items.length == 1
                    ? BorderRadius.circular(16.r)
                    : index == items.length - 1
                    ? BorderRadius.only(
                        bottomRight: Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r),
                      )
                    : index == 0
                    ? BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      )
                    : null,
                color: AppColor.white,
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.shadowColor,
                    blurRadius: 12,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text('mg/dL ', style: AppTextStyles.s14.w400.textNormal),
                      Text(
                        item.valueMgDl.toString(),
                        style: AppTextStyles.s20.w600.textNormal,
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: item.time,
                          style: AppTextStyles.s14.w400.textNormal,
                        ),
                        if (isDaily)
                          TextSpan(
                            text: ' ${item.month}',
                            style: AppTextStyles.s14.w400.subTextNormal,
                          ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4.w,
                    children: [
                      Text(
                        item.status,
                        style: AppTextStyles.s16.w500.textNormal,
                      ),
                      Container(
                        width: 16.r,
                        height: 16.r,
                        decoration: ShapeDecoration(
                          color: item.trafficColor,
                          shape: const OvalBorder(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
