import 'package:flutter/material.dart';
import 'package:testtt/screens/clockInOut.dart';
import 'package:testtt/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        appBarTheme: AppBarTheme(
          color: Color(0xFFD9073C),
        ),),
      title: 'Flutter Demo',

      home: LoginScreen(),
    );
  }
}

