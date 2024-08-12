import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();

  static Future<bool?> requestNotificationPermissions()async{
    final bool? permissionGranted = await flutterLocalNotificationsPlugin.
    resolvePlatformSpecificImplementation
    <AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    return permissionGranted;
  }
}