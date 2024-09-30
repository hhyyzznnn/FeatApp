import 'package:flutter/material.dart';
import 'package:feat/utils/appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  List<Map<String,String>> friends = [];// 검색된 친구 목록 저장
  List<Map<String,String>> searchResults = [];  // 검색된 유저 목록 저장
  final String userId = "";
  final String userName = "";
  TextEditingController searchController = TextEditingController();  // 검색창 입력 내용
  bool isSearching = false; // 검색 상태를 확인하는 변수


  // 기존 친구 목록 불러오는 함수
  Future<void> loadFriends() async {
    final Map<String, String> friends = {
    "userName": userName,
    "userId": userId,
    };

    // post 요청 보내기
    final http.Response response = await http.post(
    Uri.parse('http://'),
    headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(friends),
    );

    if (response.statusCode == 200) {

    } else {
    throw Exception('Failed to load friends');
    }
  }


  // 검색어에 맞는 모든 유저를 불러오는 함수
  Future<void> searchUsers(String query) async {

    final String search = searchController.text;

    final Map<String, String> searchResults = {
    "userName": userName,
    "userId": userId,
    };

    // post 요청 보내기
    final http.Response response = await http.post(
    Uri.parse('http://'),
    headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(searchResults),
    );

    if (response.statusCode == 200) {

    } else {
    throw Exception('Failed to load friends');
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
        appBar: buildAppBar(context, '친구'),
        body: Column(
          children: [
            Search(
                onSearch: (query) {
                  setState(() {
                    isSearching = query.isNotEmpty;
                  });
                  if (isSearching) {
                    searchUsers(query);
                  } else {
                    loadFriends();
                  }
                },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: isSearching ? searchResults.length : friends.length,
                itemBuilder: (context, index) {
                  final displayedList = isSearching ? searchResults : friends;
                  return FriendComponent(friendName: displayedList[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


class Search extends StatefulWidget {
  final Function(String) onSearch;

  Search({super.key, required this.onSearch});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: size.width * 0.9,
        height: 50,
        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Icon(Icons.search, color: Colors.white70),
            ),
            SizedBox(
              width: size.width * 0.6,
              height: 70,
              child: TextField(
                onChanged: (text) {
                  widget.onSearch(text);
                },
                decoration: InputDecoration(
                  hintText: '친구 추가 또는 검색',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white70),
                cursorColor: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class FriendComponent extends StatelessWidget {
  final Map<String, String>? friendName;

  FriendComponent({super.key, this.friendName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'calendar');
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(25, 0, 20, 0),
        width: 450,
        height: 130,
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
              ),
            ),
            SizedBox(
                width: 200,
                height: 100,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child:Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                          child: Text('친구1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                        child: Text('ID', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
