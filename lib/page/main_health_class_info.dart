import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_care_ml_app/model/health_class_info.dart';
import 'package:health_care_ml_app/page/main_health_club_page.dart';
import 'package:velocity_x/velocity_x.dart';


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
  //   print(placeList.length);
  //   setState(() {
  //     placeList.addAll(places);
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
      appBar: AppBar(
        title: Text('Tab View Example'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '생활 체육 동호회 정보'),
            Tab(text: '생활체육교실 정보'),
          ],
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
                return Column(
                  children: [
                    Text(
                      disableClassroom[index].recruitment_date.toString(),
                    ),Text(
                      disableClassroom[index].class_nm.toString(),
                    ),
                  ],
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
