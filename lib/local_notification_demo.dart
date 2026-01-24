import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'flutter_local_notification.dart';

class LocalNotificationDemo extends StatelessWidget {
  const LocalNotificationDemo({super.key});

  Future instantNotification() async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'instant_chanel',
        'instant',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      101,
      'Ordedr Confirmed',
      'Your Order is Confirmed',
      details,
    );
  }

  Future scheduleNotification() async {
    flutterLocalNotificationsPlugin.zonedSchedule(
      102,
      'Meeting Reminder',
      'Meeting in 10 min',
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      NotificationDetails(
        android: AndroidNotificationDetails(
            'meeting_chanel',
            'meeting',
          importance: Importance.max,
          priority: Priority.high
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Local Notification')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: instantNotification,
            child: Text('Instant local Notification'),
          ),
          ElevatedButton(
            onPressed: scheduleNotification,
            child: Text('10 second Schedule'),
          ),
        ],
      ),
    );
  }
}
