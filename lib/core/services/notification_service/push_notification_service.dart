import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:raai/core/services/notification_service/local_notification_service.dart';
import 'package:raai/core/utils/routes.dart';

class PushNotificationsServices {
  PushNotificationsServices._();

  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future init() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
    );
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    getToken();

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    // foreground
    foregroundNotifications();
    listenNotificationClick();
    await handleInitialMessage();
  }

  static void foregroundNotifications() {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.data['type'] == 'MEDICATION_REMINDER') {
        LocalNotificationServices.showForegroundNotifications(message);
        AppRoutes.route.push(AppRoutes.medicationReminder, extra: message.data);
      } else {
        LocalNotificationServices.showForegroundNotifications(message);
      }
    });
  }

  static Future<void> handleInitialMessage() async {
    final message = await messaging.getInitialMessage();
    if (message != null) {
      NotificationNavigation.pendingMessage = message;
    }
  }

  // static Future<void> handlerOnBackgroundMessage(RemoteMessage message) async {
  //   await Firebase.initializeApp();
  //   log(message.notification?.title ?? 'null');
  // }

  static void listenNotificationClick() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['type'] == 'MEDICATION_REMINDER') {
        AppRoutes.route.push(AppRoutes.medicationReminder, extra: message.data);
      } else {
        AppRoutes.route.push(AppRoutes.notificationScreen);
      }
    });
  }

  static Future<String?> getToken() async {
    try {
      if (Platform.isIOS) {
        await messaging.getAPNSToken();
      }
      final token = await messaging.getToken();
      log('token: $token');
      return token;
    } catch (e) {
      return null;
    }
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class NotificationNavigation {
  static RemoteMessage? pendingMessage;
}
