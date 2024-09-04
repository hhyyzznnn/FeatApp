import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProFilePage extends StatelessWidget {
  const ProFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back, size: 30), color: Colors.black87),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text('프로필', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black87
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(25.0),
                              child: CircleAvatar(
                                radius: 100, backgroundImage: AssetImage('hanni.jpeg'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey, shape: const CircleBorder(),
                                  minimumSize: const Size(75, 75), side: const BorderSide(color: Colors.white, width: 5)),
                                  onPressed: (){}, child: const Icon(Icons.camera_alt, color: Colors.white, size: 30,)),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('User Name', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
                              Text('ID', style: TextStyle(color: Colors.white, fontSize: 20))
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text('알림', style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.black87),
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.group, color: Colors.white,),
                        title: Text('친구 요청', style: TextStyle(color: Colors.white)),
                        trailing: CupertinoSwitch(
                          value: false,
                          activeColor: Colors.black87,
                          onChanged: (bool? value) {},
                        ),
                      ),
                      Container(
                        height: 1, width: MediaQuery.of(context).size.width * 0.85, color: Colors.grey,
                      ),
                      ListTile(
                        leading: Icon(Icons.person, color: Colors.white,),
                        title: Text('친구 알림', style: TextStyle(color: Colors.white)),
                        trailing: CupertinoSwitch(
                          value: false,
                          activeColor: Colors.black87,
                          onChanged: (bool? value) {},
                        ),
                      ),
                      Container(
                        height: 1, width: MediaQuery.of(context).size.width * 0.85, color: Colors.grey,
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications, color: Colors.white,),
                        title: Text('전체 알림', style: TextStyle(color: Colors.white),),
                        trailing: CupertinoSwitch(
                          value: false,
                          activeColor: Colors.black87,
                          onChanged: (bool? value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text('개인정보', style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.black87),
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 300, 10),
                        child: Text('이메일', style: TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                      Container(
                        height: 1, width: MediaQuery.of(context).size.width * 0.85, color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 300, 10),
                        child: Text('전화번호', style: TextStyle(fontSize: 15, color: Colors.white)),
                      ),                    Container(
                        height: 1, width: MediaQuery.of(context).size.width * 0.85, color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 300, 10),
                        child: Text('생년월일', style: TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.45,
                      margin: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.black87),
                      child: Text('계정 삭제', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.45,
                      margin: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.black87),
                      child: Text('로그아웃', style: TextStyle(color: Colors.red), textAlign: TextAlign.center,))
                ],
              )
            ],
          ),
        )
    );
  }
}