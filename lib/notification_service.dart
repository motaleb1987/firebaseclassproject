import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService{
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
   await Firebase.initializeApp();
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('Permission ${settings.authorizationStatus}');
    String ? token = await _messaging.getToken();
    print('Device token : ${token}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      print('Message Title : ${message.notification!.title}');
      print('Message Body : ${message.notification!.body}');
    });
  }




}