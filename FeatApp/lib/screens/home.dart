import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
                backgroundColor: Colors.white,
                title: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Feat.', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.black87)),
                ),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, size: 30,), color: Colors.black87),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(onTap: () {
                      Navigator.pushNamed(context, 'profile');
                    }, borderRadius: BorderRadius.circular(15),child: ClipOval(
                        child: Image.asset('/hanni.jpeg')
                    )),
                  )
                ]
            )),
        body: ColoredBox(
          color: Colors.white,
          child: Column(
            children: [
              Container(margin: const EdgeInsets.all(20.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Music Name', style: TextStyle(fontSize: 20, height: 2.5)),
                      Container(height: 50.0,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.black87))
                    ]),
              ),
              SizedBox(
                height: 550,
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
                      margin: const EdgeInsets.fromLTRB(30, 50, 30, 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){}, icon: const Padding(
                            padding: EdgeInsets.fromLTRB(50, 15, 0, 15),
                            child: Icon(Icons.date_range, color: Colors.white),
                          )),
                          IconButton(onPressed: (){}, icon: const Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 50, 15),
                            child: Icon(Icons.group, color: Colors.white),
                          ))
                        ],
                      )),
                  ElevatedButton(style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87, shape: const CircleBorder(), padding: const EdgeInsets.all(20),
                      minimumSize: const Size(120, 120), side: const BorderSide(color: Colors.white, width: 5)),
                      onPressed: (){}, child: const Icon(Icons.add, color: Colors.white))
                ],
              )
            ],),
        )
    );
  }
}