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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        length: 6,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'يجب إدخال رمز التحقق';
          }
          if (value.length < 6) {
            return 'رمز التحقق يجب أن يكون 6 أرقام';
          }
          return null;
        },
        keyboardType: TextInputType.number,
        errorTextSpace: 20,
        pinTheme: PinTheme(
          borderRadius: BorderRadius.circular(180),
          shape: PinCodeFieldShape.circle,
          fieldHeight: 45.r,
          fieldWidth: 45.r,
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
          LengthLimitingTextInputFormatter(6),
        ],
        controller: controller,
        onCompleted: onCompleted,
        autoDismissKeyboard: true,
        autoUnfocus: true,
        enablePinAutofill: true,
      ),
    );
  }
}
