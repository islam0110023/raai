import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:raai/core/utils/app_color.dart';

class OTPTextField extends StatelessWidget {
  const OTPTextField({super.key, this.controller, this.onCompleted});
  final TextEditingController? controller;
  final void Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        borderRadius: BorderRadius.circular(180),
        shape: PinCodeFieldShape.circle,
        fieldHeight: 52.r,
        fieldWidth: 52.r,
        activeFillColor: Colors.white,
        disabledColor: AppColor.disableNormal,
        activeColor: AppColor.primaryNormal,
        inactiveColor: AppColor.disableNormal,
        selectedColor: AppColor.secondaryNormal,
        activeBorderWidth: 3.r,
        inactiveBorderWidth: 3.r,
        selectedBorderWidth: 3.r,
        borderWidth: 3.r,
        errorBorderColor: AppColor.redNormal,
        errorBorderWidth: 3.r,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      controller: controller,
      onCompleted: onCompleted,
      autoDismissKeyboard: true,
      autoUnfocus: true,
      enablePinAutofill: true,
    );
  }
}
