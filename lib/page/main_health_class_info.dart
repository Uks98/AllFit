import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_care_ml_app/model/health_class_info.dart';
import 'package:health_care_ml_app/page/main_health_club_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../base_app_color_and_font/constant_widget.dart';


class DisableClassPage extends StatefulWidget {
  const DisableClassPage({super.key});

  @override
  State<DisableClassPage> createState() => _DisableClassPageState();
}

class _DisableClassPageState extends State<DisableClassPage> with TickerProviderStateMixin{
  List<DisableClassInfo> disableClassroom = [];

  Future<void> getDisableClass() async {
    final routeFromJsonFile = await rootBundle.loadString(
        'lib/json/KS_DSPSN_LVLH_PHSTRN_CLSSRM_DATA_INFO_202304.json');
    disableClassroom = DisableClass.fromJson(routeFromJsonFile).disableClassList ?? <DisableClassInfo>[];
    setState(() {});
  }

  // void addList() async {
  //   final List<Place> places = await getPlaceList();
  //   print(disableClassroom.length);
  //   setState(() {
  //     disableClassroom.addAll(places);
  //   });
  // }
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this); // 탭 수 지정
    // TODO: implement initState
    super.initState();
    getDisableClass();
    //print(abc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          
          title: Text(''),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: '생활 체육 동호회 정보'),
              Tab(text: '생활체육교실 정보'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await getDisableClass();
        },
        child: Text("add"),
      ),
    body:TabBarView(
      controller: _tabController,
      children: [
        // 탭 A에 해당하는 페이지
       MainClubInfoPage(),
        // 탭 B에 해당하는 페이지
      mainClassInfo(),
      ],
    ),
    );
  }

  Widget mainClassInfo() {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return SizedBox(
                  child: PhysicalModel(
                    color: Colors.white,
                    elevation: 3,
                    shadowColor: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(normalHeight),
                    child: ListTile(
                      hoverColor: Colors.grey[200],
                      contentPadding: EdgeInsets.only(left: 20),
                      title: disableClassroom[index].class_nm?.text.fontWeight(FontWeight.bold).size(normalFontSize - 1).make(),
                      subtitle: Text("${disableClassroom[index].class_location} " + disableClassroom[index].signgu_nm.toString(),style: TextStyle(fontSize: smallFontSize + 3,color: Colors.grey[600]),),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, idx) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: disableClassroom.length),
        ),
      ],
    );
  }
}
