import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(size.height * 0.05),
            child: AppBar(
                backgroundColor: Colors.white,
                title: Text('Feat.', style: TextStyle(fontSize: size.height * 0.035,fontWeight: FontWeight.bold, color: Colors.black87)),
                actions: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
                      child: IconButton(padding: EdgeInsets.zero, constraints: BoxConstraints(),onPressed: () {
                        Navigator.pushNamed(context, 'signup');
                      },
                          icon: Icon(Icons.notifications_none, size: size.height * 0.035), color: Colors.black87)),
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.025),
                    child: InkWell(onTap: () {
                      Navigator.pushNamed(context, 'profile');
                    }, borderRadius: BorderRadius.circular(size.height * 0.02), child: ClipOval(
                        child: Icon(Icons.person, size: size.height * 0.035)
                    )),
                  )
                ]
            )),
        body: ColoredBox(
          color: Colors.white,
          child: Column(
            children: [
              Container(margin: EdgeInsets.all(size.width * 0.03),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Music Name', style: TextStyle(fontSize: size.width * 0.04, height: size.height * 0.0035)),
                      Container(height: size.height * 0.06,decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.width * 0.03), color: Colors.black87))
                    ]),
              ),
              SizedBox(
                height: size.height * 0.6,
                child: PageView.builder(
                  controller: PageController(initialPage: 0, viewportFraction: 0.8),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.blue.withOpacity(index * 0.1),
                    );
                  },
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.black87),
                      margin: EdgeInsets.all(size.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pushNamed(context, 'signin');
                          }, icon: Icon(Icons.date_range, color: Colors.white)),
                          SizedBox(width: size.width * 0.2, height: size.height * 0.075,),
                          IconButton(onPressed: (){}, icon: Icon(Icons.group, color: Colors.white))
                        ],
                      )),
                  ElevatedButton(style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87.withOpacity(1), shape: const CircleBorder(), padding: EdgeInsets.all(size.width * 0.1),
                      side: const BorderSide(color: Colors.white, width: 7.5)),
                      onPressed: (){
                        Navigator.pushNamed(context, 'camera');
                      }, child: Icon(Icons.add, color: Colors.white, size: size.width * 0.1))
                ],
              )
            ],),
        )
      );
  }
}