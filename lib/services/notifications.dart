import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        Get.snackbar(title ?? "Notification", body ?? "New Notification");
      },
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notificationsPlugin.initialize(initializationSettings);

    // ✅ Request Notification Permission (Android 13+)
    if (Platform.isAndroid) {
      PermissionStatus status = await Permission.notification.request();
      if (status.isGranted) {
        print("✅ Notification permission granted!");
      } else {
        print("❌ Notification permission denied!");
      }
    }
  }

  static Future<void> showNotification() async {
    var androidDetails = const AndroidNotificationDetails(
      "channelId",
      "channelName",
      importance: Importance.high,
      priority: Priority.high,
    );

    var iOSDetails = const DarwinNotificationDetails();

    var generalNotificationDetails =
    NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await _notificationsPlugin.show(
      0,
      "Reminder",
      "This is a notification!",
      generalNotificationDetails,
    );
  }
}
