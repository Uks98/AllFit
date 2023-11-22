import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:health_care_ml_app/model/health_class_info.dart';
import 'package:health_care_ml_app/page/main_health_club_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../base_app_color_and_font/constant_widget.dart';
import '../color/color_box.dart';


class DisableClassPage extends StatefulWidget {
  const DisableClassPage({super.key});

  @override
  State<DisableClassPage> createState() => _DisableClassPageState();
}

class _DisableClassPageState extends State<DisableClassPage> with TickerProviderStateMixin{
  List<DisableClassInfo> disableClassroom = [];
  List<String> sportList = ["전체","게이트볼","탁구","당구","댄스",];
  List<DisableClassInfo> sportFilterList = [];
  int sportIndex = 0;
  Future<void> getDisableClass() async {
    final routeFromJsonFile = await rootBundle.loadString(
        'lib/json/KS_DSPSN_LVLH_PHSTRN_CLSSRM_DATA_INFO_202304.json');
    disableClassroom = DisableClass.fromJson(routeFromJsonFile).disableClassList ?? <DisableClassInfo>[];
    setState(() {});
  }
  void showAllLocations() {
    sportFilterList = disableClassroom; // 전체 리스트를 보여주기 위해 filteredPlaceList를 초기화
  }
  void getSportPlaceList(String location) {
    if (location == "전체") {
      showAllLocations(); // "전체"를 선택한 경우 전체 리스트를 보여주는 함수 호출
    } else {
      setState(() {
        sportFilterList = disableClassroom
            .where((place) => place.class_nm!.contains(location))
            .toList();
      });
      for(final x in sportFilterList){
        print(x.class_nm);
      }
    }
  }
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this); // 탭 수 지정
    // TODO: implement initState
    super.initState();
    getDisableClass();
    sportFilterList =  disableClassroom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: ColorBox.appbarColor,
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            indicatorColor: ColorBox.indicatorColor,
            dividerColor: ColorBox.appbarColor,
            labelColor: Colors.black,
            controller: _tabController,
            tabs: const [
              Tab(text: '생활 체육 동호회 정보'),
              Tab(text: '생활체육교실 정보'),
            ],
          ),
        ),
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
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10),
      child: Column(
        children: [
          SizedBox(height: normalHeight,),
        SizedBox(
        width: 400,
        height: 40,
        child:
        AnimationLimiter(
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child:  GestureDetector(
                        onTap: () {
                          setState(() {
                            sportIndex = index;
                            getSportPlaceList(sportList[index]);
                          });
                        },
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                            color: sportIndex == index
                                ? ColorBox.locationButtonColor
                                : ColorBox.unSelectColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(child: sportList[index].text.size(smallFontSize).make()),
                        ),
                      )
                    ),
                  ),
                );

              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 5,
                );
              },
              itemCount: sportList.length),
        )),
          SizedBox(height: bigHeight,),
          Expanded(
            child: AnimationLimiter(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return
                      AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child:  SizedBox(
                              child: PhysicalModel(
                                color: Colors.white,
                                elevation: 3,
                                shadowColor: Colors.blue.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(normalHeight),
                                child: ListTile(
                                  hoverColor: Colors.grey[200],
                                  contentPadding: EdgeInsets.only(left: 20),
                                  title: sportFilterList[index].class_nm?.text.fontWeight(FontWeight.w500).size(normalFontSize - 1).make(),
                                  subtitle: Text("${sportFilterList[index].class_location} " + sportFilterList[index].signgu_nm.toString(),style: TextStyle(fontSize: smallFontSize + 3,color: Colors.grey[600]),),
                                ),
                              ),
                            )
                          ),
                        ),
                      );

                  },
                  separatorBuilder: (ctx, idx) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: sportFilterList.length),
            ),
          ),
        ],
      ),
    );
  }
}
