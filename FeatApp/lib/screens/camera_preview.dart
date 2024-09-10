import 'package:flutter/material.dart';
import 'dart:io';

class PreviewPage extends StatelessWidget {
  final String imagePath;

  PreviewPage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final containerWidth = size.width * 0.92;
    final containerHeight = containerWidth * 16 / 9;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 이미지 프리뷰
          Positioned(
            bottom: size.height * 0.13, // main에서 사용한 위치와 동일
            left: size.width * 0.04, // main에서 사용한 위치와 동일
            right: size.width * 0.04, // main에서 사용한 위치와 동일
            child: Center(
              child: Container(
                width: containerWidth,
                height: containerHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(File(imagePath), fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          // 뒤로 가기 버튼
          Positioned(
            top: size.height * 0.02,
            left: size.width * 0.02,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // OK 버튼
          Positioned(
            bottom: size.height * 0.05,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // 여기에 다른 화면으로 이동하는 코드 추가하셈
                },
                child: Text('OK', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff3F3F3F), // 버튼 색상
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // 라운드 버튼
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}