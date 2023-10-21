import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_task/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('myBoxOngoing');
  await Hive.openBox('myBoxComplete');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
