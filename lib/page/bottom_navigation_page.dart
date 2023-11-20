
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_ml_app/page/select_health_care_page.dart';
import 'main_health_class_info.dart';
import 'main_health_club_page.dart';

class  BottomNavigationPage extends StatefulWidget {
  BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  //상세 페이지의 마커
  int _currentIndex = 0; // 바텀 네비게이션 현재 index
  List<Widget> appPages = [
    DisableClassPage(),
    SelectHealthCarePage(),
   // LocationPage(),

  ]; // 앱 화면들
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // LocationClass().getLocation(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black, // 선택된 아이템의 라벨 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이템의 라벨 색상
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline,color: Colors.black,),
            label: '맞춤 정보',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_outlined),
            label: '운동 추천',
          ),
        ],
      ),
      body: appPages.elementAt(_currentIndex),
    );
  }

}