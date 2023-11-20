import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:health_care_ml_app/base_app_color_and_font/constant_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../color/color_box.dart';
import '../model/health_club_data.dart';
import 'club_detail_page.dart';


class MainClubInfoPage extends StatefulWidget {
  const MainClubInfoPage({super.key});

  @override
  State<MainClubInfoPage> createState() => _MainClubInfoPageState();
}

class _MainClubInfoPageState extends State<MainClubInfoPage> {
  List<DisableClubInfo> placeList = [];
  List<DisableClubInfo> filteredPlaceList = [];
  List<DisableClubInfo> finalList = [];
  int locationIndex = 0;
  List<String> locationList = ["전체","서울","경기","경남","대구",];

  void showAllLocations() {
      filteredPlaceList = placeList; // 전체 리스트를 보여주기 위해 filteredPlaceList를 초기화
  }

  Future<void> getPlaceList() async {
    final routeFromJsonFile = await rootBundle.loadString(
        'lib/json/KS_DSPSN_LVLH_PHSTRN_CLUBMMB_CLUB_VIEWS_INFO_202304.json');
     placeList = DisableClub.fromJson(routeFromJsonFile).disableClub ?? <DisableClubInfo>[];
      filteredPlaceList = placeList;
  }

  void getLocationPlaceList(String location) {
    if (location == "전체") {
      showAllLocations(); // "전체"를 선택한 경우 전체 리스트를 보여주는 함수 호출
    } else {
      setState(() {
        filteredPlaceList = placeList
            .where((place) => place.class_location!.contains(location))
            .toList();
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlaceList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: normalHeight,),
            SizedBox(
              width: 400,
              height: 40,
              child: AnimationLimiter(
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: SlideAnimation(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  locationIndex = index;
                                  getLocationPlaceList(locationList[index]);
                                });
                              },
                              child: Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  color: locationIndex == index
                                      ? ColorBox.sportButtonColor
                                      : ColorBox.unSelectColor,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(child: locationList[index].text.size(smallFontSize).make()),
                              ),
                            )
                          ),
                        ),
                      );

                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 5,
                      );
                    },
                    itemCount: locationList.length),
              ),
            ),
            SizedBox(height: bigHeight,),

            Expanded(
              child: AnimationLimiter(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: SizedBox(
                              child: PhysicalModel(
                                color: Colors.white,
                                elevation: 3,
                                shadowColor: Colors.blue.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(normalHeight),
                                child: ListTile(
                                  onTap: (){
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ClubDetailPage(disableClubInfo: filteredPlaceList[index],); // 위에서 만든 CustomBottomSheet 위젯을 호출합니다.
                                      },
                                    );
                                  },
                                  hoverColor: Colors.grey[200],
                                  contentPadding: EdgeInsets.only(left: 20),
                                  title: filteredPlaceList[index].club_nm?.text.fontWeight(FontWeight.w500).size(normalFontSize - 1).make(),
                                  subtitle: Text("${filteredPlaceList[index].class_location} ${filteredPlaceList[index].signgu_nm}",style: TextStyle(fontSize: smallFontSize + 3,color: Colors.grey[600]),),
                                ),
                              ),
                            ),)
                          ),
                      );

                    },
                    separatorBuilder: (ctx, idx) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: filteredPlaceList.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
