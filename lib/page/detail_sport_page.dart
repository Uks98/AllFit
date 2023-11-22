import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_care_ml_app/base_app_color_and_font/constant_widget.dart';

import '../ml_kit/pose_detector.dart';
import '../model/health_recommend_data.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailSportPage extends StatelessWidget {
 RecommendSport recommendSport;

   DetailSportPage({super.key,required this.recommendSport});

  RecommendSport get _sportList => recommendSport;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          automaticallyImplyLeading: false,
          title: "추천운동".text.size(normalFontSize).make()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: normalHeight,),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    width: 250,
                    height: 360,
                    child: Image.asset(
                        "asset/squat.gif",fit: BoxFit.cover,),
                  ),
                ),
            SizedBox(height: bigHeight,),
            intro_sport_row_widget("운동명",_sportList.recommend_sport!),
            SizedBox(height: normalHeight,),
            intro_sport_row_widget("장애 유형",_sportList.disalbe_type!),
            SizedBox(height: normalHeight,),
            intro_sport_row_widget("추천 연령대",_sportList.age!),
            SizedBox(height: normalHeight,),
            intro_sport_row_widget("운동 유형",_sportList.sport_step!),
            SizedBox(height: bigHeight,),
            moveAndBackButton("AI와 함께 운동하기",()=>goAiLearningPage(context)),
            SizedBox(height: normalHeight,),
            moveAndBackButton("뒤로가기",()=>goBack(context)),
            SizedBox(height: bigHeight,),
          ],
        ),
      ),
    );
  }

  void goAiLearningPage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FaceDetectorApp()));
  }
  void goBack(BuildContext context){
    Navigator.of(context).pop();
  }
  SizedBox moveAndBackButton(String intro,VoidCallback voidCallback) {
    return SizedBox(
              height: 50,
              width: 400,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  onPressed: voidCallback, child: intro.text.make()));
  }

  Widget intro_sport_row_widget(String intro,String main) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Row(
        children: [intro.text.size(normalFontSize + 2).make(),
             SizedBox(width: 20,),
        main.text.size(normalFontSize + 2).make()],),
    );
  }
}
