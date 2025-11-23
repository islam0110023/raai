import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    super.key,
  });

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
        });
      },
      activeColor: AppColor.primaryNormal,
      checkColor: AppColor.white,
      side: BorderSide(color: AppColor.disableNormal, width: 1.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(180),
      ),
    );
  }
}
