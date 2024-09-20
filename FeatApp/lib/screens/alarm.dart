import 'package:feat/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:feat/screens/signin.dart';
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomePage(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('알림', style: TextStyle(),),
      ),
      body: ListView(
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

        ],
      )
    );
  }
}

class AlarmBox extends StatelessWidget {
  const AlarmBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
        decoration: BoxDecoration(
            color: Color(0xff3f3f3f),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.asset('hanni.jpeg'),
          ),
          title: Text('User name', style: TextStyle(color: Colors.white, fontSize: 14)),
          subtitle: Text('내용', style: TextStyle(color: Colors.white, fontSize: 14),),
        ),
      ),
    );
  }
}
