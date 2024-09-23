import 'package:flutter/material.dart';
import 'package:feat/screens/calender.dart';
import 'package:feat/screens/home.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: PreferredSize(child: FriendPageAppBar(), preferredSize: Size.fromHeight(200)),
          body: Column(
              children: [
                Search(),
                Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index){
                        return friendComponent();
                      }
                  ),
                )
              ]
          )
      ),
    );
  }
}


class FriendPageAppBar extends StatelessWidget {
  const FriendPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(20, 30, 10, 30),
                child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_rounded), iconSize: 27)
            ),
            Container(
                margin:EdgeInsets.fromLTRB(10, 30, 7, 30),
                child: Text(
                  '친구',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                )
            )
          ],
        ),
      ),
    );
  }
}

class Search extends StatefulWidget {
  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 450,
        height: 50,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: Icon(Icons.search, color: Colors.white70)
            ),
            Container(
              width: 300,
              height: 70,
              child: TextField(
                decoration: InputDecoration(
                  hintText: '친구 추가 또는 검색',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white70),
                cursorColor: Colors.white70,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class friendComponent extends StatefulWidget {
  const friendComponent({super.key});

  @override
  State<friendComponent> createState() => _friendComponentState();
}

class _friendComponentState extends State<friendComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'signin');
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(25, 0, 20, 0),
        width: 450,
        height: 130,
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.blue),
            ),
            Container(
                width: 200,
                height: 100,
                child: Column(
                  children: [
                    Align(
                      child:Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                          child: Text('친구1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                      alignment: Alignment.topLeft,
                    ),
                    Align(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Text('ID', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500))),
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