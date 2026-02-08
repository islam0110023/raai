import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/profile/data/model/items_profile_model.dart';

class CustomCardItemsProfile extends StatelessWidget {
  const CustomCardItemsProfile({
    super.key,
    required this.title,
    required this.items,
  });
  final String title;
  final List<ItemsProfileModel> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          const RSizedBox(height: 4),
          ...items.map<Widget>((e) {
            return InkWell(
              onTap: e.onTap,
              borderRadius: BorderRadius.circular(16),
              splashColor: AppColor.secondaryLightHover,
              highlightColor: AppColor.secondaryLightHover,
              hoverColor: AppColor.secondaryLightHover,
              child: Container(
                padding: REdgeInsets.all(8),
                margin: e.index == 1 || e.index == 0
                    ? REdgeInsets.only(bottom: 4)
                    : null,
                decoration: BoxDecoration(
                  borderRadius: e.index == 0
                      ? null
                      : e.index == 1
                      ? BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        )
                      : e.index == 2
                      ? BorderRadius.only(
                          bottomRight: Radius.circular(16.r),
                          bottomLeft: Radius.circular(16.r),
                        )
                      : BorderRadius.circular(16),
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
                  children: [
                    SvgPicture.asset(e.icon),
                    const RSizedBox(width: 16),
                    Expanded(
                      child: Text(
                        e.title,
                        style: AppTextStyles.s14.w400.textNormal,
                      ),
                    ),
                    const RSizedBox(width: 16),
                    Icon(Icons.arrow_forward_ios, size: 16.r),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
