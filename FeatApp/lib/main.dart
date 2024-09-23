import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'screens/signup.dart';
import 'screens/signin.dart';
import 'screens/camera.dart';
import 'screens/alarm.dart';
import 'screens/appbar.dart';
import 'screens/calender.dart';
import 'screens/friendpage.dart';
import 'screens/ootd.dart';

void main() {
  runApp(const FeatApp());
}

class FeatApp extends StatelessWidget {
  const FeatApp({super.key});

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    return userId == null; // '=='를 '!='로 수정해야 함. 코딩 위해서 임의로 바꿔놓음
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: isLoggedIn(), builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    else if (snapshot.hasData && snapshot.data == true) {
      return HomePage();
    }
    else {
      return SignInPage();
    }},
    ),
      routes: {
        'profile': (context) => ProFilePage(),
        'signup': (context) => SignUpPage(),
        'signin': (context) => SignInPage(),
        'camera': (context) => CameraPage(),
        'alarm' : (context) => AlarmPage(),
        'home' : (context) => HomePage(),
        'appbar' : (context) => MainAppBar(),
        'calender' : (context) => Calender(),
        'friendpage' : (context) => FriendPage(),
        'ootd' : (context) => ootdHomePage(),
      }
    );
  }
}