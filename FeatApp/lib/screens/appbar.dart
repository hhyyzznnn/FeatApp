import 'package:flutter/material.dart';


class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(10, 20, 0, 20),
                child: TextButton(
                    onPressed: (){},
                    style: TextButton.styleFrom(foregroundColor: Colors.black, textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
                    child: Text('Feat.'))
            ),
            Spacer(),
            Container(
                margin: EdgeInsets.fromLTRB(0, 20, 17, 20),
                child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.notifications_none),
                    iconSize: 30)
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 15, 20),
              child: GestureDetector(
                onTap: (){},
                child: Container(width: 30, height: 30, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue )), //추후 컬러 부분을 이미지로 변경하면 프로필로 변경 가능
              ),
            )
          ],
        ),
      ),
    );
  }
}