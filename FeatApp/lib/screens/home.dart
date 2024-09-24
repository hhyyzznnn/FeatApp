import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String?> homePosts = []; // 이미지 URL을 저장할 리스트

  final String userId = "user1"; // 유저 아이디 임시로 저장

  Future<void> loadPosts() async {
    final url = Uri.parse('http://localhost:8080/load/posts/home');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId}),
      );

      if (response.statusCode == 200) {
        setState(() {
          homePosts = List<String?>.from(
              jsonDecode(response.body)); // JSON 데이터를 리스트로 변환
          print(homePosts);
        });
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadPosts(); // 페이지가 생성될 때 데이터 로드
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.05),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text('Feat.',
              style: TextStyle(
                  fontSize: size.height * 0.035,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3F3F3F))),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {
                  Navigator.pushNamed(context, 'alarm');
                },
                icon: Icon(Icons.notifications_none, size: size.height * 0.035),
                color: Color(0xff3F3F3F),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.025),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'profile');
                },
                borderRadius: BorderRadius.circular(size.height * 0.02),
                child: ClipOval(
                  child: Icon(Icons.person, size: size.height * 0.035),
                ),
              ),
            )
          ],
        ),
      ),
      body: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(size.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Music Name',
                      style: TextStyle(
                          fontSize: size.width * 0.04,
                          height: size.height * 0.0035)),
                  Container(
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius:
                          BorderRadius.circular(size.width * 0.03), color: Color(0xff3f3f3f),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff000000).withOpacity(0.25),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: Offset(0, 4) // changes position of shadow
                          ),
                        ],
                      )
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.6,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.8),
                itemCount: 50,
                itemBuilder: (context, index) {
                  final imageUrl = homePosts[index];
                  return Container(
                    margin: EdgeInsets.only(right: 28), // 좌우 여백 설정
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 설정
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff000000).withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 4)
                        ),
                      ],
                    ),
                    child: imageUrl != null
                    ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover, // 이미지가 컨테이너에 맞게 조정됨
                  )
                      : Center(child: Text('No Image')), // 이미지가 없을 때,
                  );
                },
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xff3f3f3f)),
                    margin: EdgeInsets.all(size.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'calender');
                            },
                            icon: Icon(Icons.date_range, color: Colors.white)),
                        SizedBox(
                          width: size.width * 0.2,
                          height: size.height * 0.075,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'friendpage');
                            },
                            icon: Icon(Icons.group, color: Colors.white))
                      ],
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff3f3f3f).withOpacity(1),
                        shape: const CircleBorder(),
                        padding: EdgeInsets.all(size.width * 0.1),
                        side:
                            const BorderSide(color: Colors.white, width: 5)),
                    onPressed: () {
                      Navigator.pushNamed(context, 'camera');
                    },
                    child: Icon(Icons.add,
                        color: Colors.white, size: size.width * 0.1))
              ],
            )
          ],
        ),
      ),
    );
  }
}
