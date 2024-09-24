import 'package:flutter/material.dart';

class appbar2 extends StatelessWidget {
  const appbar2({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
      color: Colors.white,
      child: Row(
        children: [
          TextButton(onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
          child: Container(
            child: Row(
              children: [
                Icon(Icons.arrow_back,color: Colors.black, ),
                Spacer(),
                Text('알람', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),)
              ],
            ),
          ))
        ],
      ),
    );
  }
}

