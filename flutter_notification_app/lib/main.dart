import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Notifications PoC'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showNotification();
          },
          child: Text('Send Notification'),
        ),
      ),
    );
  }

  Future<void> _showNotification() async {
    var androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'news_channel', // channelId
      'News Updates', // channelName
      channelDescription:
          'Get notified about the latest news', // channelDescription
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      channelShowBadge: true,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // No iOS-specific settings
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Web3',
      'Leezgow',
      platformChannelSpecifics,
      payload: 'action',
    );
  }
}
