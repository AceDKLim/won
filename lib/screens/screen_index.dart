import 'package:flutter/material.dart';
import '../tab/tab_map.dart';
import '../tab/tab_request.dart';
import '../tab/tab_community.dart';
import '../tab/tab_mypage.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    MapTab(),
    RequestTab(),
    CommunityTab(),
    MyPageTab()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 12),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: '헌옷수거함'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: '수거요청'),
          BottomNavigationBarItem(icon: Icon(Icons.comment), label: '커뮤니티'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
        ],
      ),
      body: _tabs[_currentIndex],
    );
  }
}
