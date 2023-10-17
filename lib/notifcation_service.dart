import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  var mNotificationManager = FlutterLocalNotificationsPlugin();

  ///BigPictureStyleInformation(DrawableResourceAndroidBitmap('app_icon'), contentTitle: "Full Image", summaryText: "From Raman"),
  var androidNotificationDetails = const AndroidNotificationDetails(
      "test", "test Channel",
      autoCancel: true,
      ongoing: true,
      styleInformation:InboxStyleInformation(
          ["Okay", "catch you later", "TTYL", "Good Night"],
        summaryText: "+more msgs",
        contentTitle: "see all messages"
      ),
      actions: [
        AndroidNotificationAction("1", "Reply", inputs: [
          AndroidNotificationActionInput(
              label: "Write a message..",
              choices: ["Okay", "catch you later", "TTYL", "Good Night"])
        ]),
        AndroidNotificationAction("2", "Cancel", cancelNotification: true)
      ],
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

    mNotificationManager
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
  }

  sendNotification(
      {int id = 100, required String title, required String body}) {
    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iOSNotificationDetails,
        macOS: iOSNotificationDetails);

    mNotificationManager.show(id, title, body, notificationDetails);
  }

  periodicNotification(
      {int id = 100, required String title, required String body}) {
    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iOSNotificationDetails,
        macOS: iOSNotificationDetails);

    mNotificationManager.periodicallyShow(
        id, title, body, RepeatInterval.everyMinute, notificationDetails);
  }

  scheduleNotification(
      {int id = 100, required String title, required String body}) async {
    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iOSNotificationDetails,
        macOS: iOSNotificationDetails);




    tz.setLocalLocation(
      tz.getLocation(
        await FlutterTimezone.getLocalTimezone(),
      ),
    );

    mNotificationManager.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(minutes: 1)),
        notificationDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
    );
  }

  cancelNotification({int id = 100}) {
    mNotificationManager.cancel(id);
  }
}
