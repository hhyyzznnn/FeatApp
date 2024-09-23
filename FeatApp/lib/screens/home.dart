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
    //final pageController = PageController(viewportFraction: 1.1);

    return Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(size.height * 0.05),
            child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                title: Text('Feat.', style: TextStyle(fontSize: size.height * 0.035,fontWeight: FontWeight.bold, color: Colors.black87)),
                actions: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
                      child: IconButton(padding: EdgeInsets.zero, constraints: BoxConstraints(), onPressed: () {
                        Navigator.pushNamed(context, 'alarm');
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
                      Container(
                          height: size.height * 0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.width * 0.03),
                          color: Color(0xff3f3f3f),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          )
                      )
                    ]),
              ),
              SizedBox(
                height: size.height * 0.6,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.8),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 28),
                      decoration: BoxDecoration(
                        color: Color(0xffEBEBEB),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                    );
                  },
                  //controller: PageController(initialPage: 0, viewportFraction: 0.8),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xff3f3f3f),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(size.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pushNamed(context, 'calender');
                          }, icon: Icon(Icons.date_range, color: Colors.white)),
                          SizedBox(width: size.width * 0.2, height: size.height * 0.075,),
                          IconButton(onPressed: (){
                            Navigator.pushNamed(context, 'friendpage');
                          }, icon: Icon(Icons.group, color: Colors.white))
                        ],
                      )),
                  ElevatedButton(style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff3f3f3f).withOpacity(1),
                      shape: const CircleBorder(), padding: EdgeInsets.all(size.width * 0.1),
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