import 'package:firebaseclassproject/task_manager.dart';
import 'package:firebaseclassproject/voting_page.dart';
import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BD Voting',
      home: TaskManager(),
    );
  }
}
