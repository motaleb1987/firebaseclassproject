import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'flutter_local_notification.dart';
class LocalNotificationDemo extends StatelessWidget {
  const LocalNotificationDemo({super.key});

Future instantNotification() async {
  final details = NotificationDetails(
    android: AndroidNotificationDetails(
        'instant_chanel',
        'instant',
      importance: Importance.max,
      priority: Priority.high
    ),);
    await  flutterLocalNotificationsPlugin.show(
          101,
          'Ordedr Confirmed',
          'Your Order is Confirmed',
          details
      );

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Notification'),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: instantNotification, child: Text('Instant local Notification'))
        ],
      ),
    );
  }
}
