import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        'profile': (context) => ProFilePage(),
        'signup': (context) => SignUpPage()
      }
    );
  }
}