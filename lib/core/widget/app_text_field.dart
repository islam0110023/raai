import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hint,
    this.label,
    this.prefixIcon,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.suffix,
    this.keyboardType,
    this.helperText,
    this.maxLength,
    this.isRequired = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.inputFormatters,
    this.validator,
    this.initialText,
    this.style,
    this.padding,
    this.helperStyle,
    this.onTap,
    this.textAlign = TextAlign.start,
  });

  final String? label;
  final String hint;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final String? helperText;
  final int? maxLength;
  final bool isRequired;
  final bool readOnly;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? initialText;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;
  final TextStyle? helperStyle;
  final VoidCallback? onTap;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          RichText(
            text: TextSpan(
              text: label,
              style: AppTextStyles.s16.w500.textDark,
              children: isRequired
                  ? const [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  : [],
            ),
          ),
        if (label != null) const RSizedBox(height: 8),

        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          maxLength: maxLength,
          maxLines: maxLines,
          readOnly: readOnly,
          initialValue: initialText,
          onTap: onTap,
          textAlign: textAlign,
          validator:
              validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
          inputFormatters: inputFormatters,
          style: style ?? AppTextStyles.s16.w600.black,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            labelStyle: AppTextStyles.s14.w300.subTextNormal,
            hintStyle: AppTextStyles.s14.w400.subTextNormal,
            helperText: helperText,
            helperStyle: helperStyle ?? AppTextStyles.s14.w400.textNormal,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AppColor.subtextNormal)
                : null,
            suffixIcon: suffix,
            counterText: '',
            contentPadding:
                padding ??
                REdgeInsets.symmetric(vertical: 5.r, horizontal: 10.r),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.secondaryNormal,
                width: 1.8.r,
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.subtextLightHover,
                width: 1.8.r,
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.redNormalHover,
                width: 1.8.r,
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.borderColor, width: 1.8.r),
              borderRadius: BorderRadius.circular(24.r),
            ),
          ),
        ),
      ],
    );
  }
}
