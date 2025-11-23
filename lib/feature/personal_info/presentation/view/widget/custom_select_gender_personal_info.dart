import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_button.dart';

class CustomSelectGenderPersonalInfo extends StatefulWidget {
  const CustomSelectGenderPersonalInfo({super.key});

  @override
  State<CustomSelectGenderPersonalInfo> createState() =>
      _CustomSelectGenderPersonalInfoState();
}

class _CustomSelectGenderPersonalInfoState
    extends State<CustomSelectGenderPersonalInfo> {
  bool isMale = false;
  bool isFemale = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.w,
      children: [
        Expanded(
          child: AppButton.outline(
            text: 'ذكر',
            onPressed: () {
              setState(() {
                isMale = true;
                isFemale = false;
              });
            },
            radius: 8,
            borderColor: isMale
                ? AppColor.primaryNormal
                : AppColor.disableNormal,
            textStyle: isMale
                ? AppTextStyles.s14.w400.primaryNormal
                : AppTextStyles.s14.w400.disableNormal,
          ),
        ),
        Expanded(
          child: AppButton.outline(
            text: 'انثي',
            onPressed: () {
              setState(() {
                isMale = false;
                isFemale = true;
              });
            },
            radius: 8,
            borderColor: isFemale
                ? AppColor.primaryNormal
                : AppColor.disableNormal,
            textStyle: isFemale
                ? AppTextStyles.s14.w400.primaryNormal
                : AppTextStyles.s14.w400.disableNormal,
          ),
        ),
      ],
    );
  }
}
