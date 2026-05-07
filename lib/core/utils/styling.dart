import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/constants.dart';

class AppTextStyles {
  AppTextStyles._();
  static final FontSizeStyle s32 = const FontSizeStyle(32);

  static final FontSizeStyle s28 = const FontSizeStyle(28);

  static final FontSizeStyle s24 = const FontSizeStyle(24);

  static final FontSizeStyle s20 = const FontSizeStyle(20);

  static final FontSizeStyle s16 = const FontSizeStyle(16);

  static final FontSizeStyle s14 = const FontSizeStyle(14);
  static final FontSizeStyle s12 = const FontSizeStyle(12);
}

class FontSizeStyle {
  const FontSizeStyle(this._fontSize);
  final double _fontSize;
  FontWeightStyle get w300 => FontWeightStyle(_fontSize, FontWeight.w300);
  FontWeightStyle get w400 => FontWeightStyle(_fontSize, FontWeight.w400);
  FontWeightStyle get w500 => FontWeightStyle(_fontSize, FontWeight.w500);
  FontWeightStyle get w600 => FontWeightStyle(_fontSize, FontWeight.w600);
  FontWeightStyle get w700 => FontWeightStyle(_fontSize, FontWeight.w700);
  FontWeightStyle get w800 => FontWeightStyle(_fontSize, FontWeight.w800);
}

class FontWeightStyle {
  const FontWeightStyle(this._fontSize, this._fontWeight);
  final double _fontSize;
  final FontWeight _fontWeight;

  TextStyle get white => _createStyle(color: AppColor.white);
  TextStyle get black => _createStyle(color: AppColor.black);
  TextStyle get textNormal => _createStyle(color: AppColor.textNormal);
  TextStyle get subTextNormal => _createStyle(color: AppColor.subtextNormal);
  TextStyle get textDark => _createStyle(color: AppColor.textDark);
  TextStyle get primaryNormal => _createStyle(color: AppColor.primaryNormal);
  TextStyle get greenDarker => _createStyle(color: AppColor.greenDarker);
  TextStyle get redDarker => _createStyle(color: AppColor.redDarker);
  TextStyle get disableNormal => _createStyle(color: AppColor.disableNormal);
  TextStyle get disableNormalHover => _createStyle(color: AppColor.disableNormalHover);
  TextStyle get redNormal => _createStyle(color: AppColor.redNormal);
  TextStyle get blue => _createStyle(color: AppColor.blue);
  TextStyle get green => _createStyle(color: AppColor.green);
  TextStyle get greenNormal => _createStyle(color: AppColor.greenNormal);
  TextStyle get redNormalActive =>
      _createStyle(color: AppColor.redNormalActive);
  TextStyle get primaryDarker => _createStyle(color: AppColor.primaryDarker);
  TextStyle get secondaryDarkHover =>
      _createStyle(color: AppColor.secondaryDarkHover);
  TextStyle get secondaryLightHover =>
      _createStyle(color: AppColor.secondaryLightHover);

  TextStyle _createStyle({required Color color}) {
    return TextStyle(
      fontSize: _fontSize.sp,
      fontWeight: _fontWeight,
      fontFamily: AppConstant.kFontFamily,
      color: color,
    );
  }
}
