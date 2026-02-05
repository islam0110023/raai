import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
    this.style,
    this.textStyle,
    this.width,
    required this.radius,
    this.isOutline = false,
  });

  factory AppButton.filled({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? size,
    double? width,
    bool loading = false,
    Color buttonColor = AppColor.primaryNormal,
    double? radius = 45,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      loading: loading,
      width: width,
      isOutline: false,
      radius: radius!,
      style: ElevatedButton.styleFrom(
        // disabledBackgroundColor: AppColor.teal200,
        backgroundColor: buttonColor,
        minimumSize: size,
        elevation: 0,
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 12.r, horizontal: 24.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.r),
          side: BorderSide(color: AppColor.secondaryLightHover, width: 3.r),
        ),
      ),
      textStyle: textStyle ?? AppTextStyles.s16.w500.white,
    );
  }

  factory AppButton.outline({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool loading = false,
    Color borderColor = AppColor.primaryNormal,
    Color textColor = AppColor.primaryNormal,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? size,
    double? width,
    Color? backgroundColor,
    double? radius = 45,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      loading: loading,
      width: width,
      isOutline: true,
      radius: radius!,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColor.white,
        foregroundColor: textColor,
        minimumSize: size,
        side: BorderSide(color: borderColor, width: 3.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.r),
        ),
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 12.r, horizontal: 24.r),
      ),
      textStyle:
          textStyle ?? AppTextStyles.s16.w500.white.copyWith(color: textColor),
    );
  }
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final double? width;
  final double radius;
  final bool isOutline;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: Container(
        padding: isOutline ? REdgeInsets.all(3) : null,
        decoration: isOutline
            ? BoxDecoration(
                color: AppColor.secondaryLightHover,
                borderRadius: BorderRadius.circular(radius.r),
              )
            : null,
        child: ElevatedButton(
          style: style,
          onPressed: loading ? null : onPressed,
          child: loading
              ? const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColor.white,
                  ),
                )
              : Text(text, style: textStyle),
        ),
      ),
    );
  }
}
