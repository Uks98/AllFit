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
          title: "상세 페이지".text.make(),
        ),
        body: SizedBox(
          // Bottom Sheet의 내용을 구성하는 위젯들을 추가합니다.
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  disableClubInfo.classNM!.text.size(normalFontSize).make(),
                  SizedBox(height: smallHeight,),
                  Text(
                    "${disableClubInfo.classLocation} ${disableClubInfo.signguNM}",
                    style: TextStyle(
                        fontSize: normalFontSize, color: Colors.grey[600]),
                  ),
                  SizedBox(height: smallHeight,),

                  Divider(thickness: 1,color: Colors.grey[300],),
                  SizedBox(height: smallHeight,),
                  Row(
                    children: [
                          "운동 형태".text.size(normalFontSize).make(),
                            disableClubInfo.classType!.text.size(normalFontSize).make().pOnly(left: bigWidth)
                    ],
                  ),
                  SizedBox(height: normalHeight,),
                  Row(
                    children: [
                      "장애 유형".text.size(normalFontSize).make(),
                      disableClubInfo.disableType!.text.size(normalFontSize).make().pOnly(left: bigWidth)
                    ],
                  ),
                  SizedBox(height: normalHeight,),
                  Row(
                    children: [
                      "운영 시간".text.size(normalFontSize).make(),
                      disableClubInfo.operateTime!.text.size(normalFontSize).make().pOnly(left: bigWidth)
                    ],
                  ),
                  SizedBox(height: normalHeight,),
                  "동호회 소개".text.size(normalFontSize).make(),
                  SizedBox(height: normalHeight,),
                  disableClubInfo.detailInfo != ""? Container(child: disableClubInfo.detailInfo!.text.color(Colors.grey[600]).size(smallFontSize + 3).make()): "아직 소개가 없어요".text.make()
                ],
              ),
            ),
          ),
        ));
  }
}
