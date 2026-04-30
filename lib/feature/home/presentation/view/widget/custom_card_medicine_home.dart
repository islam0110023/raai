import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';

class CustomCardMedicineHome extends StatelessWidget {
  const CustomCardMedicineHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                Container(
                  width: 149.w,
                  height: 134.h,
                  decoration: BoxDecoration(
                    color: AppColor.subtextLight,
                    borderRadius: BorderRadius.circular(16.r),
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
                          'Metformin',
                          style: AppTextStyles.s14.w400.textNormal,
                        ),
                      ),
                      const RSizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '1 ',
                              style: AppTextStyles.s14.w400.secondaryDarkHover,
                            ),
                            TextSpan(
                              text: 'كبسولة',
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
                              text: '09:00',
                              style: AppTextStyles.s14.w400.secondaryDarkHover,
                            ),
                            TextSpan(
                              text: ' | ',
                              style: AppTextStyles.s14.w400.subTextNormal,
                            ),
                            TextSpan(
                              text: 'يوميا',
                              style: AppTextStyles.s14.w400.textNormal,
                            ),
                          ],
                        ),
                      ),
                      const RSizedBox(height: 15),
                      AppButton.filled(
                        text: 'أخذ الدواء',
                        isOutlineColor: false,
                        textStyle: AppTextStyles.s14.w400.secondaryLightHover,
                        padding: REdgeInsets.all(8),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: REdgeInsets.symmetric(horizontal: 16,vertical: 4),
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
                Text('الان',style: AppTextStyles.s14.w400.white,),
                const RSizedBox(width: 5),
                Icon(CupertinoIcons.clock,color: AppColor.white,size: 14.r,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
