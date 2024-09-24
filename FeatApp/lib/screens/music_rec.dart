import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'home.dart';

class MusicRecScreen extends StatelessWidget {
  final List<String> musicList = [
    'Song 1',
    'Song 2',
    'Song 3',
    'Song 4',
    'Song 5',
  ]; // 음악 목록

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cWidth = size.width * 0.92;
    final cHeight = cWidth * 16 / 9;
    final widgetWidth = 60.0; // 위젯의 가로 크기
    final widgetHeight = 60.0; // 위젯의 세로 크기

    return Scaffold(
      body: Stack(
        children: [
          // 뒤로 가기 버튼
          Positioned(
            top: size.height * 0.02,
            left: size.width * 0.02,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment(0, 0.65),
            child: Container(
              width: cWidth * 0.65,
              height: cHeight * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 뒤로 감기 버튼
                  IconButton(
                    icon: SvgPicture.asset('assets/icons/rewind.svg'),
                    iconSize: widgetWidth,
                    onPressed: () {},
                  ),
                  // 정지 버튼
                  IconButton(
                    icon: SvgPicture.asset('assets/icons/pause.svg'),
                    iconSize: widgetWidth,
                    onPressed: () {},
                  ),
                  // 앞으로 감기 버튼
                  IconButton(
                    icon: SvgPicture.asset('assets/icons/fast_forward.svg'),
                    iconSize: widgetWidth,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.8),
            child: Container(
              width: size.width * 0.9,
              height: size.height * 0.05,
              color: Colors.grey,
              child: Row(
                children: [
                  // volume down 버튼
                  IconButton(
                    icon: SvgPicture.asset('assets/icons/volume_down.svg'),
                    iconSize: widgetWidth,
                    onPressed: () {},
                  ),
                  // volume 조정 영역
                  Align(
                    alignment: Alignment(0, 0),
                    child: Container(
                      width: size.width * 0.66,
                      height: size.height * 0.011,
                      decoration: BoxDecoration(
                        color: Color(0xffD9D9D9),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  // volume up 버튼
                  IconButton(
                    icon: SvgPicture.asset('assets/icons/volume_up.svg'),
                    iconSize: widgetWidth,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.8),
            child: Container(
              width: size.width * 0.9,
              height: size.height * 0.1,
              decoration: ShapeDecoration(
                color: Color(0xFFF0EADF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.58),
            child: Container(
              width: size.width * 0.9,
              height: size.height * 0.002,
              color: Color(0xFFc7c7c7),
            ),
          ),
          // Music List
          Align(
            alignment: Alignment(0, -0.36),
            child: Container(
              width: size.width * 0.88,
              height: size.height * 0.3, // 리스트가 표시될 높이 조정
              child: ListView.builder(
                itemCount: musicList.length, // 음악 목록 개수에 따라 동적으로 생성
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(13),
                    decoration: ShapeDecoration(
                      color: Color(0xFF3F3F3F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Text(
                      musicList[index],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}