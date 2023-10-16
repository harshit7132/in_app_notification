import 'package:flutter/material.dart';
import 'package:notify_me_131/notifcation_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notificationService = NotificationService();

  @override
  void initState() {
    super.initState();

    notificationService.initialize((details) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text('From Notification'),
              ),
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () {
                  notificationService.sendNotification(
                      title: "New Message", body: "Message from Raman");
                },
                child: Text('Notify')),
            OutlinedButton(
                onPressed: () {
                  notificationService.scheduleNotification(
                      id: 200,
                      title: "Drink Water",
                      body: "It has been 1 min since you've not drunk water.");
                },
                child: Text('Schedule Notification')),
            OutlinedButton(
                onPressed: () {
                  notificationService.cancelNotification();
                },
                child: Text('Cancel Notification'))
          ],
        ),
      ),
    );
  }
}
