import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaseclassproject/firebase_options.dart';
import 'package:firebaseclassproject/my_app.dart';
import 'package:firebaseclassproject/notification_service.dart';
import 'package:flutter/cupertino.dart';

// main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//  await NotificationService.initialize();
//  await Firebase.initializeApp(
//    options: DefaultFirebaseOptions.currentPlatform
//  );
//   // FirebaseMessaging.onBackgroundMessage(
//   //   firebase
//   // );
//
//   runApp(MyApp());
// }

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ১. ফায়ারবেস ইনিশিয়ালাইজ করা
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  // ২. লোকাল নোটিফিকেশন সার্ভিস ইনিশিয়ালাইজ (আপনার যদি আলাদা ক্লাস থাকে)
  await NotificationService.initialize();

  // ৩. ব্যাকগ্রাউন্ড মেসেজ হ্যান্ডেলার সেট করা
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // ৪. ফোরগ্রাউন্ডে (অ্যাপ ওপেন থাকা অবস্থায়) নোটিফিকেশন লিসেনার
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      // এখানে আপনার NotificationService ব্যবহার করে নোটিফিকেশন দেখান
      NotificationService.showNotification(message);
    }
  });

  runApp(MyApp());
}