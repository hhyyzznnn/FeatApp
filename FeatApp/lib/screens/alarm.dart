import 'package:feat/screens/home.dart';
import 'package:flutter/material.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

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
        ],
      )
    );
  }
}

class AlarmBox extends StatelessWidget {
  const AlarmBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
