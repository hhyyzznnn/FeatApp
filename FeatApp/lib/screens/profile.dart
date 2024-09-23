import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:feat/screens/signin.dart';
import 'package:http/http.dart' as http;

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  @override
  Future<void> deleteUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage())
    );
  } // 유저 아이디 기기에서 삭제하는 함수 (로그아웃)

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    final camStatus = await Permission.camera.request();
    final phoStatus = await Permission.photos.request();
  } // 카메라와 갤러리의 권한 획득 여부

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
  } // 프로필 버튼 눌렀을 때 카메라, 갤러리 선택창 표시

  bool reqNotifications = false;
  bool friNotifications = false;
  bool allNotifications = false; // 알림 활성화 여부

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

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<void> fetchProfileData() async {
    String? userId = await getUserId();

    if (userId != null) {
      final url = Uri.parse(''); // URL 추가
      final response = await http.post(
        url,
        headers: {}, // 추가 코딩 필요
        body: jsonEncode({'userId': userId})
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(padding: EdgeInsets.zero, constraints: BoxConstraints(), onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back, size: size.width * 0.075), color: Colors.black87),
          title: Padding(
            padding: EdgeInsets.all(size.width * 0.015),
            child: Text('프로필', style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width * 0.065)),
          ),
          backgroundColor: Colors.white,
          centerTitle: false,
        ),
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
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff3f3f3f)
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Color(0xff3f3f3f)),
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Color(0xff3f3f3f)),
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
                    ElevatedButton(onPressed: () {
                      deleteUserId(); // 정말 로그아웃하시겠습니까? 등 팝업창 추가해야함. 지금은 유저아이디 즉시 삭제.
                    }, style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: Color(0xff3f3f3f),
                        minimumSize: Size(size.width * 0.45, size.height * 0.075), alignment: Alignment.center),
                        child: Text('계정 삭제', style: TextStyle(color: Colors.white),)),
                    ElevatedButton(onPressed: () {
                      deleteUserId();
                    }, style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: Color(0xff3f3f3f),
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