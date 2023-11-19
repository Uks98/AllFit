import 'package:flutter/material.dart';
import 'package:health_care_ml_app/base_app_color_and_font/constant_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../model/health_club_data.dart';

class ClubDetailPage extends StatelessWidget {
  DisableClubInfo disableClubInfo;

  ClubDetailPage({super.key, required this.disableClubInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: "상세 페이지"?.text.make(),
        ),
        body: SizedBox(
          // Bottom Sheet의 내용을 구성하는 위젯들을 추가합니다.
          height: 400.0,
          // Bottom Sheet의 내용을 구성하는 위젯들을 추가합니다.
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                disableClubInfo.club_nm!.text.size(normalFontSize).make(),
                SizedBox(height: smallHeight,),
                Text(
                  "${disableClubInfo.class_location} ${disableClubInfo.signgu_nm}",
                  style: TextStyle(
                      fontSize: normalFontSize, color: Colors.grey[600]),
                ),
                SizedBox(height: smallHeight,),

                Divider(thickness: 1,color: Colors.grey[300],),
                SizedBox(height: smallHeight,),
                Row(
                  children: [
                        "운동 형태         ".text.size(normalFontSize).fontWeight(FontWeight.bold).make(),
                          disableClubInfo.class_type!.text.size(normalFontSize).make()
                  ],
                ),
                SizedBox(height: normalHeight,),
                Row(
                  children: [
                    "장애 유형         ".text.size(normalFontSize).fontWeight(FontWeight.bold).make(),
                    disableClubInfo.disable_type!.text.size(normalFontSize).make()
                  ],
                ),
                SizedBox(height: normalHeight,),
                Row(
                  children: [
                    "운동 형태         ".text.size(normalFontSize).fontWeight(FontWeight.bold).make(),
                    disableClubInfo.operate_time!.text.size(normalFontSize).make()
                  ],
                ),
                SizedBox(height: normalHeight,),
                "동호회 소개".text.size(normalFontSize).fontWeight(FontWeight.bold).make(),
                SizedBox(height: normalHeight,),
                disableClubInfo.detail_info != ""? Container(child: disableClubInfo.detail_info!.text.size(normalFontSize).make()): "아직 소개가 없어요".text.make()
              ],
            ),
          ),
        ));
  }
}
