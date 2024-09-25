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
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  File? _image;
  final ImagePicker picker = ImagePicker();

  Map userSetting = {}; // 유저 세팅을 저장할 맵
  Map userInfo = {}; // 유저 정보를 저장할 리스트

  final String userId = "user1"; // 임의로 작성한 유저 아이디

  Future<void> loadSettings() async {

    final url = Uri.parse('http://localhost:8080/load/alarmSetting'); // 설정 서버 주소 추가
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId}),
      );

      if (response.statusCode == 200) {
        setState(() {
          userSetting = Map.from(jsonDecode(response.body));

          reqNotifications = userSetting['friendRequest'] == 'on';
          friNotifications = userSetting['friendAlarm'] == 'on';
          allNotifications = userSetting['entireAlarm'] == 'on';
          print(userSetting);
        });
      } else {
        throw Exception('Failed to load setttings');
      }
    } catch (e) {
      print('Error: $e');
    }
  } // 유저 설정 불러오는 함수(서버)

  Future<void> loadInfo() async {

    final url = Uri.parse('http://localhost:8080/load/userInfo'); // 유저 정보 서버 주소 추가
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId}),
      );

      if (response.statusCode == 200) {
        setState(() {
          userInfo = Map.from(jsonDecode(response.body)); // JSON 데이터를 리스트로 변환
          print(userInfo);
        });
      } else {
        throw Exception('Failed to load user info');
      }
    } catch (e) {
      print('Error: $e');
    }
  } // 유저 정보 불러오는 함수 (서버)

  Future<void> deleteUserId(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage())
    );
  } // 로그아웃 함수

  Future<void> deleteAccount(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null) {
      final url = Uri.parse('http://'); // 계정 삭제 기능이 구현된 서버 주소
      try {
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"userId": userId}),
        );

        if (response.statusCode == 200) {
          await prefs.remove('userId');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
          );
        } else {
          throw Exception('Failed to delete account');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  } // 계정 삭제 함수

  @override
  void initState() {
    super.initState();
    requestPermissions();
    loadInfo();
    loadSettings();
  }

  Future<void> requestPermissions() async {
    final camStatus = await Permission.camera.request();
    final phoStatus = await Permission.photos.request();
  } // 카메라, 갤러리 권한 (미사용)

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      
      uploadProfileImage(_image!);
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
  } // 사진 촬영 or 갤러리 선택

  bool reqNotifications = false;
  bool friNotifications = false;
  bool allNotifications = false; // 서버 연결 후 코드 삭제할 예정

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

  Future<void> uploadProfileImage(File image) async {
    final url = Uri.parse('http://localhost:8080/load/'); // 프로필 사진 서버 주소

    final mimeTypeData = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');
    if (mimeTypeData == null || mimeTypeData.length != 2) {
      print('Failed to detect MIME type');
      return;
    } // 파일의 형식 확인

    final request = http.MultipartRequest('POST', url);

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]), // MIME 타입 설정
      ),
    );

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
        final responseBody = await http.Response.fromStream(response);
        final responseData = jsonDecode(responseBody.body);
        print('Response: ${responseData}');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  } // 프로필 사진 업로드

  void logoutConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('로그아웃'),
          content: const Text('정말 로그아웃하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                deleteUserId(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } // 로그아웃 확인

  void deleteAccountConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('계정 삭제'),
          content: const Text('정말 계정을 삭제하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                deleteAccount(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } // 계정 삭제 확인

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
                                ? FileImage(_image!)
                                : const AssetImage('hanni.jpeg') as ImageProvider,
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
                        leading: Icon(Icons.group, color: Colors.white),
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
                        subtitle: Text(userInfo['userEmail'], style: TextStyle(color: Colors.grey))
                      ),
                      Divider(height: 1,color: Colors.grey, indent: size.width * 0.025, endIndent: size.width * 0.025),
                      ListTile(onTap: () {}, dense: true,
                          title: Text('전화번호', style: TextStyle(color: Colors.white, fontSize: size.width * 0.045)),
                          subtitle: Text(userInfo['userPhone'], style: TextStyle(color: Colors.grey))
                      ),
                      Divider(height: 1, color: Colors.grey, indent: size.width * 0.025, endIndent: size.width * 0.025),
                      ListTile(onTap: () {}, dense: true,
                          title: Text('생년월일', style: TextStyle(color: Colors.white, fontSize: size.width * 0.045)),
                          subtitle: Text(userInfo['birthday'], style: TextStyle(color: Colors.grey))
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
                        logoutConfirm(context);
                      }, style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: Color(0xff3f3f3f),
                        minimumSize: Size(size.width * 0.45, size.height * 0.075), alignment: Alignment.center),
                        child: Text('계정 삭제', style: TextStyle(color: Colors.white),)),
                    ElevatedButton(onPressed: () {
                      deleteAccountConfirm(context);
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