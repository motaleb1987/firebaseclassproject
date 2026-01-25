import 'package:firebaseclassproject/local_notification_demo.dart';
import 'package:firebaseclassproject/login_page.dart';
import 'package:firebaseclassproject/task_manager.dart';
import 'package:firebaseclassproject/voting_page.dart';
import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BD Voting',
      home: LoginPage(),
    );
  }
}
