import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: false,
      validator: (value) {
        if (value != true) {
          return 'يجب الموافقة على الشروط والأحكام';
        }
        return null;
      },
      builder: (state) {
        return Checkbox(
          value: isChecked,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (value) {
            setState(() {
              state.didChange(value);
              isChecked = value!;
            });
          },
          activeColor: AppColor.primaryNormal,
          checkColor: AppColor.white,
          side: BorderSide(
            color: state.hasError ? AppColor.redNormal : AppColor.disableNormal,
            width: 1.r,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(180),
          ),
        );
      },
    );
  }
}
