import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/asset_image.dart';
import 'package:raai/core/utils/styling.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({super.key, this.onPressed, this.message, this.subMessage});
  final VoidCallback? onPressed;
  final String? message;
  final String? subMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // if (isExpanded) const RSizedBox(height: 55),
          // if (isExpanded)
          //   Align(
          //     alignment: AlignmentDirectional.topStart,
          //     child: AppButtonBack(
          //       onPressed: () {
          //         context.pop();
          //       },
          //       isLabel: false,
          //     ),
          //   ),
          // if (isExpanded) const RSizedBox(height: 16),
          Image.asset(AppImage.soon, width: 300.r, height: 300.r),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 26),
            child: Text(
              message ?? 'لا يوجد بيانات الان',
              style: AppTextStyles.s20.w600.textNormal,
              textAlign: TextAlign.center,
            ),
          ),
          const RSizedBox(height: 16),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 50),
            child: Text(
              subMessage ?? 'قم باضافه',
              style: AppTextStyles.s14.w400.subTextNormal,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
