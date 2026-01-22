import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaseclassproject/firebase_options.dart';
import 'package:firebaseclassproject/my_app.dart';
import 'package:firebaseclassproject/notification_service.dart';
import 'package:flutter/cupertino.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Initialed
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Local Notification service initialed (if have separate class)
  await NotificationService.initialize();

  // Background message handler setup
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Four ground (if have open app ) notification listener
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      // এখানে আপনার NotificationService ব্যবহার করে নোটিফিকেশন দেখান
      NotificationService.showNotification(message);
    }
  });

  runApp(MyApp());
}
