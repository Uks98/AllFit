import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_care_ml_app/base_app_color_and_font/constant_widget.dart';
import 'package:velocity_x/velocity_x.dart';
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
  Future<void> getPlaceList() async {
    final routeFromJsonFile = await rootBundle.loadString(
        'lib/json/KS_DSPSN_LVLH_PHSTRN_CLUBMMB_CLUB_VIEWS_INFO_202304.json');
     placeList = DisableClub.fromJson(routeFromJsonFile).disableClub ?? <DisableClubInfo>[];

    filteredPlaceList = placeList.where((place) => place.class_type!.contains('게이트볼') && place.class_location!.contains("경기") && place.disable_type!.contains("청각장애")).toList();


    setState(() {});
  }

  // void addList() async {
  //   final List<Place> places = await getPlaceList();
  //   print(placeList.length);
  //   setState(() {
  //     placeList.addAll(places);
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlaceList();
    //print(abc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: ,),
      floatingActionButton: FloatingActionButton(
        heroTag: "av",
        onPressed: () async{
          await getPlaceList();

        },
        child: Text("add"),
      ),
      body: Column(
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
                        onTap: (){
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return ClubDetailPage(disableClubInfo: placeList[index],); // 위에서 만든 CustomBottomSheet 위젯을 호출합니다.
                            },
                          );
                        },
                        hoverColor: Colors.grey[200],
                        contentPadding: EdgeInsets.only(left: 20),
                        title: placeList[index].club_nm?.text.fontWeight(FontWeight.bold).size(normalFontSize - 1).make(),
                        subtitle: Text("${placeList[index].class_location} " + placeList[index].signgu_nm.toString(),style: TextStyle(fontSize: smallFontSize + 3,color: Colors.grey[600]),),
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, idx) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: placeList.length),
          ),
        ],
      ),
    );
  }
}
