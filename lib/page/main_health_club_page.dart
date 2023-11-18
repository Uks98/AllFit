import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/health_club_data.dart';


class MainClubInfoPage extends StatefulWidget {
  const MainClubInfoPage({super.key});

  @override
  State<MainClubInfoPage> createState() => _MainClubInfoPageState();
}

class _MainClubInfoPageState extends State<MainClubInfoPage> {
  List<DisableClubInfo> placeList = [];

  Future<void> getPlaceList() async {
    final routeFromJsonFile = await rootBundle.loadString(
        'lib/json/KS_DSPSN_LVLH_PHSTRN_CLUBMMB_CLUB_VIEWS_INFO_202304.json');
     placeList = DisableClub.fromJson(routeFromJsonFile).disableClub ?? <DisableClubInfo>[];
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
                  return Column(
                    children: [
                  Text(
                  placeList[index].class_type.toString(),
                  ),Text(
                  placeList[index].club_nm.toString(),
                  ),
                    ],
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
