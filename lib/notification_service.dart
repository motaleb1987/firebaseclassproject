import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await Firebase.initializeApp();

    // Request for Permission
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    // print('Permission : ${settings.authorizationStatus}');
    // String ? token = await _messaging.getToken();
    // print('Device token : ${token}');

    // Local Notification setup (with Android icon)
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );
    await _localNotifications.initialize(initSettings);

    // Device TOKEN Print
    String? token = await _messaging.getToken();
    print('Device token : $token');

    //  // Four ground listener creation (worked with app open)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message Title : ${message.notification!.title}');
      print('Message Body : ${message.notification!.body}');
    });
  }

  // This is main method for Notification
  static Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
          'high_importance_channel', // channel Id,
          'High Importance Notifications', //  channel Name
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );
    _localNotifications.show(
      message.notification.hashCode, // unique id
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
    );
  }
}
