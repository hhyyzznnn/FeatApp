import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:feat/screens/signin.dart';
import 'package:http/http.dart' as http;
import 'package:feat/utils/appbar.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  List<String?> userSetting = []; // 유저 설정을 저장할 리스트
  List<String?> userInfo = []; // 유저 정보를 저장할 리스트


  final String userId = "user1";

  Future<void> loadSettings() async {

    final url = Uri.parse('http://localhost:8080/load/'); // 설정 서버 주소 추가
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId}),
      );

      if (response.statusCode == 200) {
        setState(() {
          userSetting = List<String?>.from(jsonDecode(response.body));

          reqNotifications = userSetting[0] == 'true';
          friNotifications = userSetting[1] == 'true';
          allNotifications = userSetting[2] == 'true';
          print(userSetting);
        });
      } else {
        throw Exception('Failed to load setttings');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> loadInfo() async {

    final url = Uri.parse('http://localhost:8080/load/'); // 유저 정보 서버 주소 추가
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId}),
      );

      if (response.statusCode == 200) {
        setState(() {
          userInfo = List<String?>.from(jsonDecode(response.body)); // JSON 데이터를 리스트로 변환
          print(userInfo);
        });
      } else {
        throw Exception('Failed to load user info');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage())
    );
  }

  void initState() {
    super.initState();
    requestPermissions();
    loadInfo();
    loadSettings();
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
  bool allNotifications = false; // 서버 연결 후 코드 삭제할 예정

  Future<void> updateNotificationStatus(String type, bool value) async {
    final url = Uri.parse('http://localhost:8080/load/');  // 유저 설정 서버 주소 추가

    try {
      final response = await http.post(
        url,
        body: {
          'type': type,            // 알림 유형 (req, fri, all 등)
          'status': value.toString(),  // 알림 상태 (true/false)
        },
      );

      if (response.statusCode == 200) {
        print('Notification updated successfully');
      } else {
        print('Failed to update notification: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating notification: $error');
    }
  }

  void toggleReqNotifications(bool? value) {
    setState(() {
      reqNotifications = value ?? false;
    });
    updateNotificationStatus('req', reqNotifications);  // 서버로 상태 전송
  }

  void toggleFriNotifications(bool? value) {
    setState(() {
      friNotifications = value ?? false;
    });
    updateNotificationStatus('fri', friNotifications);  // 서버로 상태 전송
  }

  void toggleAllNotifications(bool? value) {
    setState(() {
      allNotifications = value ?? false;
    });
    updateNotificationStatus('all', allNotifications);  // 서버로 상태 전송
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: buildAppBar(context, '프로필'),
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
                        subtitle: Text(userInfo[0]!, style: TextStyle(color: Colors.grey))
                      ),
                      Divider(height: 1,color: Colors.grey, indent: size.width * 0.025, endIndent: size.width * 0.025),
                      ListTile(onTap: () {}, dense: true,
                          title: Text('전화번호', style: TextStyle(color: Colors.white, fontSize: size.width * 0.045)),
                          subtitle: Text(userInfo[1]!, style: TextStyle(color: Colors.grey))
                      ),
                      Divider(height: 1, color: Colors.grey, indent: size.width * 0.025, endIndent: size.width * 0.025),
                      ListTile(onTap: () {}, dense: true,
                          title: Text('생년월일', style: TextStyle(color: Colors.white, fontSize: size.width * 0.045)),
                          subtitle: Text(userInfo[2]!, style: TextStyle(color: Colors.grey))
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