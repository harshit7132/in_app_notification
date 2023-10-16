import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  var mNotificationManager = FlutterLocalNotificationsPlugin();

  var androidNotificationDetails = const AndroidNotificationDetails(
      "test", "test Channel",
      autoCancel: true,
      ongoing: false,
      largeIcon: DrawableResourceAndroidBitmap('app_icon'));

  var iOSNotificationDetails = DarwinNotificationDetails();


  void initialize(onNotificationTap) {
    var androidInitSettings = AndroidInitializationSettings('app_icon');

    var iOSSettings = DarwinInitializationSettings();

    var macOSSettings = DarwinInitializationSettings();

    var initSettings = InitializationSettings(
        android: androidInitSettings, iOS: iOSSettings, macOS: macOSSettings);

    mNotificationManager.initialize(initSettings,
        onDidReceiveNotificationResponse: onNotificationTap);

    mNotificationManager.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
  }

  sendNotification(
      {int id = 100, required String title, required String body}) {
    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iOSNotificationDetails,
        macOS: iOSNotificationDetails);

    mNotificationManager.show(id, title, body, notificationDetails);
  }

  scheduleNotification({int id = 100, required String title, required String body}){
    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iOSNotificationDetails,
        macOS: iOSNotificationDetails);

    mNotificationManager.periodicallyShow(id, title, body, RepeatInterval.everyMinute, notificationDetails);
  }

  cancelNotification({int id = 100}){
    mNotificationManager.cancel(id);
  }
}
