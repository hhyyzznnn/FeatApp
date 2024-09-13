import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    final camStatus = await Permission.camera.request();
    final phoStatus = await Permission.photos.request();
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  void showPicker(BuildContext context) {
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      return SafeArea(child: Wrap(
        children: [
          ListTile(
              title: Text('카메라로 촬영'), onTap: () {
            pickImage(ImageSource.camera);
            Navigator.pop(context);
          }),
          ListTile(
              title: Text('갤러리에서 선택'), onTap: () {
            pickImage(ImageSource.gallery);
            Navigator.pop(context);
          }),
          ListTile(
              title: Text('취소'), onTap: () {
            Navigator.pop(context);
          }),
        ],
      ));
    });
  }

  bool reqNotifications = false;
  bool friNotifications = false;
  bool allNotifications = false;

  void toggleReqNotifications(bool? value) {
    setState(() {
      reqNotifications = value ?? false;
    });
  }

  void toggleFriNotifications(bool? value) {
    setState(() {
      friNotifications = value ?? false;
    });
  }

  void toggleAllNotifications(bool? value) {
    setState(() {
      allNotifications = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(
              size.width * 0.025,
              size.height * 0.035,
              size.width * 0.025,
              size.width * 0.015,
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(padding: EdgeInsets.zero, constraints: BoxConstraints(), onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back, size: size.width * 0.075), color: Colors.black87),
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.015),
                      child: Text('프로필', style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width * 0.065)),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black87
                  ),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(size.width * 0.05),
                            child: CircleAvatar(
                              radius: size.width * 0.2, backgroundImage: _image != null
                                ? FileImage(  File(_image!.path))
                                : const AssetImage('hanni.jpeg')
                                  as ImageProvider,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(size.width * 0.025),
                            child: ElevatedButton(style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(size.width * 0.025),backgroundColor: Colors.grey, shape: CircleBorder(), side: BorderSide(color: Colors.white, width: 3)),
                                onPressed: () => showPicker(context),
                                child: Icon(Icons.camera_alt, color: Colors.white, size: size.width * 0.075))
                          )
                        ],
                      ),
                      SizedBox(width: size.width * 0.03,),
                      Column(
                        children: [
                          Text('User Name', style: TextStyle(color: Colors.white, fontSize: size.width * 0.06, fontWeight: FontWeight.bold)),
                          Text('ID', style: TextStyle(color: Colors.white, fontSize: size.width * 0.05))
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.025),
                  child: Text('알림', style: TextStyle(fontSize: size.width * 0.04, color: Colors.grey, fontWeight: FontWeight.bold)),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.black87),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.group, color: Colors.white,),
                        title: Text('친구 요청', style: TextStyle(color: Colors.white)),
                        trailing: CupertinoSwitch(
                          value: reqNotifications,
                          activeColor: Colors.black,
                          onChanged: toggleReqNotifications,
                        ),
                      ),
                      Divider(height: 1, color: Colors.grey,indent: size.width * 0.025, endIndent: size.width * 0.025),
                      ListTile(
                        leading: Icon(Icons.person, color: Colors.white,),
                        title: Text('친구 알림', style: TextStyle(color: Colors.white)),
                        trailing: CupertinoSwitch(
                          value: friNotifications,
                          activeColor: Colors.black,
                          onChanged: toggleFriNotifications,
                        ),
                      ),
                      Divider(height: 1, color: Colors.grey,indent: size.width * 0.025, endIndent: size.width * 0.025),
                      ListTile(
                        leading: Icon(Icons.notifications, color: Colors.white,),
                        title: Text('전체 알림', style: TextStyle(color: Colors.white),),
                        trailing: CupertinoSwitch(
                          value: allNotifications,
                          activeColor: Colors.black,
                          onChanged: toggleAllNotifications,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.025),
                  child: Text('개인정보', style: TextStyle(fontSize: size.width * 0.04, color: Colors.grey, fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.black87),
                  child: Column(
                    children: [
                      ListTile(onTap: () {}, dense: true,
                        title: Text('이메일', style: TextStyle(color: Colors.white, fontSize: size.width * 0.045)),
                        subtitle: Text('email@email.com', style: TextStyle(color: Colors.grey))
                      ),
                      Divider(height: 1,color: Colors.grey, indent: size.width * 0.025, endIndent: size.width * 0.025),
                      ListTile(onTap: () {}, dense: true,
                          title: Text('전화번호', style: TextStyle(color: Colors.white, fontSize: size.width * 0.045)),
                          subtitle: Text('010 - 1234 - 5678', style: TextStyle(color: Colors.grey))
                      ),
                      Divider(height: 1, color: Colors.grey, indent: size.width * 0.025, endIndent: size.width * 0.025),
                      ListTile(onTap: () {}, dense: true,
                          title: Text('생년월일', style: TextStyle(color: Colors.white, fontSize: size.width * 0.045)),
                          subtitle: Text('2000 / 01 / 01', style: TextStyle(color: Colors.grey))
          ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: Colors.black87,
                        minimumSize: Size(size.width * 0.45, size.height * 0.075), alignment: Alignment.center),
                        child: Text('계정 삭제', style: TextStyle(color: Colors.white),)),
                    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: Colors.black87,
                        minimumSize: Size(size.width * 0.45, size.height * 0.075), alignment: Alignment.center),
                        child: Text('로그아웃', style: TextStyle(color: Colors.red),)),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}