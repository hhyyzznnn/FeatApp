import 'package:flutter/material.dart';
import 'appbar.dart';

class ootdHomePage extends StatelessWidget {
  ootdHomePage({Key? key, this.year, this.month, this.day}) : super(key:key);

  var year;
  var month;
  var day;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(child: MainAppBar(), preferredSize: Size.fromHeight(200)),
        body: ootdBody(year: year, month: month, day: day),
      ),
    );
  }
}


class ootdBody extends StatelessWidget {
  ootdBody({Key? key, this.year, this.month, this.day}) : super(key:key);

  var year;
  var month;
  var day;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(27, 10, 0, 10),
                  child: Text(year.toString() +'. '+month.toString()+'. '+day.toString(), style: TextStyle(fontSize: 22))),
              Spacer()
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
            height: 600,
            width: 450,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                height: 100,
                width: 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey),
              ),
              Container(
                height: 100,
                width: 200,
                child: Column(
                  children: [
                    Align(alignment: Alignment.centerLeft ,child: Text('Music Name', style: TextStyle(fontSize: 22))),
                    Align(alignment: Alignment.centerLeft ,child: Text('0000', style: TextStyle(fontSize: 15))),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}