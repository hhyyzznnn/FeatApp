import 'package:flutter/material.dart';
import 'package:feat/utils/appbar.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, '알람'),
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
        margin: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.015, size.width * 0.05, size.height * 0.015),
        padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
        width: size.width * 0.9,
        height: size.height * 0.125,
        decoration: BoxDecoration(
          color: Color(0xff3F3F3F),
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 4)
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Icon(Icons.circle, color: Color(0xffebebeb), size: size.width * 0.175 ),
            ),
            SizedBox(
                height: size.height * 0.1,
                width: size.width * 0.5,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child:Container(
                          margin: EdgeInsets.only(left: size.width * 0.05, top: size.height * 0.015),
                          child: Text('Username', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          margin: EdgeInsets.only(left: size.width * 0.05),
                          child: Text('내용', style: TextStyle(fontSize: 14, color: Colors.white))),
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
