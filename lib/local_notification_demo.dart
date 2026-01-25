import 'dart:io';

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

  Future dailyNotification() async {
    final now = DateTime.now();
    final scheduleTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      now.hour,
      (now.minute + 1) % 60,
    );
   await flutterLocalNotificationsPlugin.zonedSchedule(
        103,
        'daily schedule title',
        'Daily Schedule Body',
        scheduleTime,
        NotificationDetails(
          android: AndroidNotificationDetails('schedule_chanel', 'schedule')
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
    );
  }

  // schedule notification er kaj hoy nai. abar dekhte hobe.
  Future scheduleNotification() async {
    if (Platform.isAndroid) {
      final androidPlugin = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      bool? allowed = await androidPlugin?.requestExactAlarmsPermission();
      if (allowed == false) {
        await androidPlugin?.requestExactAlarmsPermission();
      }
    }
    await flutterLocalNotificationsPlugin.zonedSchedule(
      102,
      'Meeting Reminder',
      'Meeting in 10 min',
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'meeting_chanel',
          'meeting',
          importance: Importance.max,
          priority: Priority.high,
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
          ElevatedButton(
            onPressed: dailyNotification,
            child: Text('Schedule Notification'),
          ),
        ],
      ),
    );
  }
}
