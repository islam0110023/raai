import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:raai/core/utils/app_color.dart';

abstract class AppConstant {
  static const kFontFamily = 'ReadEx Pro';
  static const cacheKeyUserTokenKeyName = 'userToken';
  static const cacheKeyUserRoleKeyName = 'userRole';
  static const cacheKeyShowOnBoarding = 'showOnBoarding';
  static const cacheKeyIsLoggedIn = 'isLoggedIn';
  static const kDurationSplash = 3;

  static void precacheAppImages(BuildContext context) {
    final List<AssetImage> imagesToPrecache = [];

    for (final image in imagesToPrecache) {
      precacheImage(image, context);
    }
  }

  static String formatRecordedAtLikeUI(String isoDate) {
    final date = DateTime.parse(isoDate).toLocal();

    final time = DateFormat('h:mm', 'en').format(date);
    final amPm = DateFormat('a', 'ar').format(date); // ص / م
    final day = DateFormat('d', 'en').format(date);
    final month = DateFormat('MMMM', 'ar').format(date);
    final year = DateFormat('y', 'en').format(date);

    return '$time $amPm $day $month $year';
  }

  // static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  // buildShowSnackBar(
  //   BuildContext context,
  //   String message, [
  //   ContentType type = ContentType.failure,
  //   String title = 'Oops',
  // ]) {
  //   return ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //       content: AwesomeSnackbarContent(
  //         title: title,
  //         message: message,
  //         messageTextStyle: Styling.font16white600,
  //         contentType: type,
  //       ),
  //     ),
  //   );
  // }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: 140.r),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: SizedBox(
              width: 60.r,
              height: 60.r,
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? const Center(child: CupertinoActivityIndicator())
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryNormal,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  static Map<String, dynamic> decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(decoded);

    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid payload');
    }

    return payloadMap;
  }

  // static int calculateAge(String dateOfBirth) {
  //   try {
  //     final dob = DateFormat('dd/MM/yyyy').parse(dateOfBirth);
  //     final today = DateTime.now();
  //     int age = today.year - dob.year;
  //     if (today.month < dob.month ||
  //         (today.month == dob.month && today.day < dob.day)) {
  //       age--;
  //     }
  //     return age;
  //   } catch (e) {
  //     return 0;
  //   }
  // }
}
