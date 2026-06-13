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
  static const cacheKeyCaregiverIsLoggedIn = 'isLoggedInCaregiver';
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

  static String formatSugarTimeAtLikeUI(String isoDate) {
    final date = DateTime.parse(isoDate).toLocal();

    final time = DateFormat('h:mm', 'en').format(date);
    final amPm = DateFormat('a', 'ar').format(date); // ص / م

    return '$time $amPm';
  }

  static String formatSugarMonthAtLikeUI(String isoDate) {
    final date = DateTime.parse(isoDate).toLocal();

    final day = DateFormat('d', 'en').format(date);
    final month = DateFormat('M', 'en').format(date);

    return '$month/$day';
  }

  static int calculateAge(String dateOfBirth) {
    final dob = DateTime.parse(dateOfBirth).toLocal();
    final today = DateTime.now().toLocal();
    int age = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  static DateTime? getMaxDate(DateTime? date1, DateTime? date2) {
    if (date1 == null && date2 == null) return null;
    if (date1 == null) return date2;
    if (date2 == null) return date1;

    return date1.isAfter(date2) ? date1 : date2;
  }

  static String formatLastAdded(DateTime? date) {
    if (date == null) return 'اخر اضافه : لا يوجد';

    final localDate = date.toLocal();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateDay = DateTime(localDate.year, localDate.month, localDate.day);

    final timeFormat = DateFormat('hh:mm a', 'en');
    final time = timeFormat
        .format(localDate)
        .replaceAll('AM', 'ص')
        .replaceAll('PM', 'م');

    if (dateDay == today) {
      return 'اخر اضافه : اليوم $time';
    }

    if (dateDay == yesterday) {
      return 'اخر اضافه : أمس $time';
    }

    final fullDate = DateFormat('dd/MM/yyyy', 'en').format(localDate);
    return 'اخر اضافه : $fullDate $time';
  }

  static String getLastSeen(DateTime date) {
    final lastActivity = date.toLocal();
    final diff = DateTime.now().difference(lastActivity);

    if (diff.inSeconds < 60) {
      return 'آخر تحديث: الآن';
    }

    if (diff.inMinutes < 60) {
      final m = diff.inMinutes;

      if (m == 1) return 'آخر تحديث: منذ دقيقة';
      if (m == 2) return 'آخر تحديث: منذ دقيقتين';
      if (m <= 10) return 'آخر تحديث: منذ $m دقائق';

      return 'آخر تحديث: منذ $m دقيقة';
    }

    if (diff.inHours < 24) {
      final h = diff.inHours;

      if (h == 1) return 'آخر تحديث: منذ ساعة';
      if (h == 2) return 'آخر تحديث: منذ ساعتين';
      if (h <= 10) return 'آخر تحديث: منذ $h ساعات';

      return 'آخر تحديث: منذ $h ساعة';
    }

    final d = diff.inDays;

    if (d == 1) return 'آخر تحديث: منذ يوم';
    if (d == 2) return 'آخر تحديث: منذ يومين';
    if (d <= 10) return 'آخر تحديث: منذ $d أيام';

    return 'آخر تحديث: منذ $d يوم';
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

  static String getArabicPeriod(DateTime? dateTime) {
    final hour = dateTime?.hour ?? 50;

    if (hour < 12) return 'صباحًا';
    if (hour < 17) return 'ظهرًا';
    if (hour < 20) return 'مساءً';
    return 'ليلًا';
  }

  static String getRemainingTime(DateTime medicationDate) {
    final difference = medicationDate.difference(DateTime.now());

    if (difference.isNegative) {
      return 'انتهى';
    }

    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;

    if (hours > 0) {
      return '$hoursس $minutesد';
    }

    return '$minutesد';
  }

  static String getPeriod(String time) {
    final hour = int.parse(time.split(':')[0]);

    return hour >= 12 ? 'مساءً' : 'صباحاً';
  }

  static String formatTime(String time) {
    final parts = time.split(':');

    int hour = int.parse(parts[0]);
    final minute = parts[1];

    hour = hour % 12;
    if (hour == 0) hour = 12;

    return '${hour.toString().padLeft(2, '0')}:$minute';
  }

  static List<String> generateMedicationTimes({
    required String startTime,
    required int dosesPerDay,
  }) {
    final parts = startTime.split(':');

    final startMinutes = int.parse(parts[0]) * 60 + int.parse(parts[1]);

    final intervalMinutes = (24 * 60) ~/ dosesPerDay;

    final times = <String>[];

    for (int i = 0; i < dosesPerDay; i++) {
      final totalMinutes = (startMinutes + (i * intervalMinutes)) % (24 * 60);

      final hour = totalMinutes ~/ 60;
      final minute = totalMinutes % 60;

      times.add(
        '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}',
      );
    }

    return times;
  }

  static String formatTime1(DateTime dateTime) {
    return DateFormat('hh:mm', 'en').format(dateTime);
  }

  static String formatArabicTime(String time) {
    final parts = time.split(':');

    int hour = int.parse(parts[0]);
    final minute = parts[1];

    final period = hour >= 12 ? 'مساءً' : 'صباحاً';

    hour = hour % 12;

    if (hour == 0) {
      hour = 12;
    }

    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  static String buildMedicationSummary({
    required int taken,
    required int missed,
    required int upcoming,
    required int snoozed,
  }) {
    final parts = <String>[];

    if (taken > 0) {
      parts.add('$taken تم أخذها');
    }

    if (missed > 0) {
      parts.add('$missed متأخرة');
    }

    if (snoozed > 0) {
      parts.add('$snoozed مؤجلة');
    }

    if (upcoming > 0) {
      parts.add('$upcoming قادمة');
    }

    if (parts.isEmpty) {
      return 'لا توجد جرعات';
    }

    return parts.join(' - ');
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
