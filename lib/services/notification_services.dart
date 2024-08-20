import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<bool?> requestNotificationPermissions() async {
    final bool? permissionGranted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    return permissionGranted;
  }

  static void onTap(NotificationResponse? response) {
    // Handle notification tap
  }

  static Future<void> init() async {
    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,
    );
  }

static Future<bool> showScheduledNotification({
  required TimeOfDay time,
  required DateTime date,
  required String title,
  required String body,
}) async {
  const AndroidNotificationDetails android = AndroidNotificationDetails(
    'id3',
    'Scheduled Notification',
    importance: Importance.max,
    priority: Priority.high
  );
  const NotificationDetails details = NotificationDetails(android: android);

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

  final scheduledDate = tz.TZDateTime(
    tz.local,
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute
  );

  try {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      Random().nextInt(100000),  // Generate a random integer ID
      title,
      body,
      scheduledDate,
      details,
      androidAllowWhileIdle: true,  // Allow notification when device is idle
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
    );
    return true; // Indicate success
  } catch (e) {
    // You might want to throw the error here instead of returning false
    // This allows the caller to handle the error more specifically
    throw Exception('Failed to schedule notification: ${e.toString()}');
  }
}
}