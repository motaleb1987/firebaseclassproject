import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void>firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await  Firebase.initializeApp();
}

class NotificationService{
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
   await Firebase.initializeApp();

   // ১. পারমিশন রিকোয়েস্ট
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    // print('Permission : ${settings.authorizationStatus}');
    // String ? token = await _messaging.getToken();
    // print('Device token : ${token}');

   // ২. লোকাল নোটিফিকেশন সেটআপ (অ্যান্ড্রয়েড আইকন সেট করা)
   const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
   const InitializationSettings initSettings = InitializationSettings(android: androidSettings);
   await _localNotifications.initialize(initSettings);

   // ৩. ডিভাইস টোকেন প্রিন্ট করা
   String? token = await _messaging.getToken();
   print('Device token : $token');

// ৪. ফোরগ্রাউন্ড লিসেনার
   FirebaseMessaging.onMessage.listen((RemoteMessage message){
      print('Message Title : ${message.notification!.title}');
      print('Message Body : ${message.notification!.body}');
    });
  }

// ৫. নোটিফিকেশন দেখানোর মূল মেথড
  static Future<void> showNotification(RemoteMessage message)async {
    AndroidNotificationDetails androidDetails = const AndroidNotificationDetails(
        'high_importance_channel', // channel Id,
        'High Importance Notifications',//  channel Name
      importance: Importance.max,
      priority: Priority.high,
      playSound: true
    );

    NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);
    _localNotifications.show(
        message.notification.hashCode, // unique id
        message.notification!.title,
        message.notification!.body,
        notificationDetails
    );

  }


}