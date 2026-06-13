import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:raai/core/utils/routes.dart';

class LocalNotificationServices {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future init() async {
    final InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );
    await flutterLocalNotificationsPlugin.initialize(
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: notificationTapBackground,
      settings: settings,
    );
  }

  static void showForegroundNotifications(RemoteMessage message) async {
    final NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        'medication_alarm_v1',
        'Medication Alarm',
        channelDescription: 'Medication reminders',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        usesChronometer: true,
        category: AndroidNotificationCategory.alarm,
        visibility: NotificationVisibility.public,
        ongoing: true,
        autoCancel: false,
        channelBypassDnd: true,
        audioAttributesUsage: AudioAttributesUsage.alarm,
        sound: RawResourceAndroidNotificationSound('ra3y_alarm'),
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
    flutterLocalNotificationsPlugin.show(
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: details,
      payload: message.data.toString(),
      id: DateTime.now().millisecondsSinceEpoch.remainder(2147483647),
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  final payload = jsonDecode(response.payload!);
  if (payload['type'] == 'MEDICATION_REMINDER') {
    AppRoutes.route.push(AppRoutes.medicationReminder, extra: payload);
  } else {
    AppRoutes.route.push(AppRoutes.notificationScreen);
  }
}
