import 'package:feat/screens/appbar2.dart';
import 'package:feat/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(200), child: appbar2()),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
            AlarmBox(),
          ],
        ),
      )
    );
  }
}

class AlarmBox extends StatelessWidget {
  const AlarmBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'calendar');
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(25, 10, 20, 10),
        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
        width: 200,
        height: 90,
        decoration: BoxDecoration(
          color: Color(0xff3F3F3F),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),

        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset('hanni.jpeg', width: 50, height: 50,),

            ),
            Container(
                width: 100,
                height: 90,
                child: Column(
                  children: [
                    Align(
                      child:Container(
                          margin: EdgeInsets.fromLTRB(20, 22, 0, 0),
                          child: Text('username', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white))),
                      alignment: Alignment.topLeft,
                    ),
                    Align(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text('내용', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white))),
                      alignment: Alignment.topLeft,
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
