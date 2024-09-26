import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:flutter_sound/flutter_sound.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String?> homePosts = []; // 이미지 URL을 저장할 리스트

  final String userId = "user1"; // 유저 아이디 임시로 저장

  Future<void> loadPosts() async {
    final url = Uri.parse('http://192.168.63.212:8080/load/posts/home');
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
                  fontSize: size.height * 0.04,
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
                  Stack(
                    children: [
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
                      ),
                      Center(child: SoundWaveform())
                    ],
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
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(  // 경계에 맞게 자르기
                      borderRadius: BorderRadius.circular(10),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: imageUrl != null
                            ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        )
                            : Center(child: Text('No Image'))
                      ),
                    ),
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
                      color: Color(0xff3f3f3f),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff000000).withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4) // changes position of shadow
                        ),
                      ],
                    ),
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xff3f3f3f),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff000000).withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 4) // changes position of shadow
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'camera');
                  },
                  child: Container(
                    width: size.width * 0.275,
                    height: size.width * 0.275,
                    decoration: BoxDecoration(
                      color: Color(0xff3f3f3f),
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(width: size.width * 0.015, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff000000).withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4) // changes position of shadow
                        ),
                      ],
                    ),
                    child: Icon(Icons.add,
                        color: Colors.white, size: size.width * 0.12)
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SoundWaveform extends StatefulWidget {
  const SoundWaveform({super.key});

  @override
  State<SoundWaveform> createState() => _SoundWaveformState();
}

class _SoundWaveformState extends State<SoundWaveform> with TickerProviderStateMixin {
  late AnimationController controller;
  final int count = 30;  // 막대 개수
  final double minHeight = 10.0;  // 최소 높이
  final double maxHeight = 50.0;  // 최대 높이
  List<double> amplitudes = List.filled(30, 10.0);  // 파형 높이 저장
  FlutterSoundPlayer? _player;
  Random random = Random();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),  // 애니메이션 속도
    )..repeat();

    _player = FlutterSoundPlayer();
    startAudio(); // 오디오 재생 시작
  }

  @override
  void dispose() {
    controller.dispose();
    _player?.closePlayer();  // 리소스 정리
    super.dispose();
  }

  // 오디오 재생 및 시각화 시작
  Future<void> startAudio() async {
    await _player!.openPlayer();
    await _player!.startPlayer(
      fromURI: 'assets/your_audio_file.mp3', // 오디오 파일 경로 지정
      codec: Codec.mp3,
      whenFinished: () {
        setState(() {
          _player!.stopPlayer();
        });
      },
    );

    // 주기적으로 임의의 파형 높이를 업데이트
    _player!.onProgress!.listen((e) {
      setState(() {
        // 랜덤하게 막대 높이를 업데이트
        amplitudes = List.generate(count, (i) => minHeight + random.nextDouble() * (maxHeight - minHeight));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (c, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(count, (i) {
            double height = amplitudes[i];  // 랜덤 높이 설정
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              margin: i == (count - 1) ? EdgeInsets.zero : const EdgeInsets.only(right: 5),
              height: height,
              width: 6,  // 막대 너비
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.6 + 0.4 * controller.value),  // 동적으로 색상 변경
                borderRadius: BorderRadius.circular(9999),
              ),
            );
          }),
        );
      },
    );
  }
}

