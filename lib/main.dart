import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseclassproject/firebase_options.dart';
import 'package:firebaseclassproject/my_app.dart';
import 'package:flutter/cupertino.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform
 );
  runApp(MyApp());
}