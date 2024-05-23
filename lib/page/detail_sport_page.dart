import 'package:flutter/material.dart';
import 'package:health_care_ml_app/base_app_color_and_font/constant_widget.dart';

import '../ml_kit/pose_detector.dart';
import '../model/health_recommend_data.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailSportPage extends StatelessWidget {
  RecommendSport recommendSport;

  DetailSportPage({super.key, required this.recommendSport});

  RecommendSport get _sportList => recommendSport;

  void goAiLearningPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const FaceDetectorApp()));
  }

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: "추천운동".text.size(normalFontSize).make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: normalHeight,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(bigWidth)),
              child: VxBox(
                child: Image.asset(
                  "asset/squat.gif",
                  fit: BoxFit.cover,
                ),
              ).width(250).height(360).make(),
            ),
            introSportRowWidget("운동명", _sportList.recommendSport!),
            HeightBox(
              bigHeight,
            ),
            introSportRowWidget("장애 유형", _sportList.disableType!),
            HeightBox(
              bigHeight,
            ),
            introSportRowWidget("추천 연령대", _sportList.age!),
            HeightBox(
              bigHeight,
            ),
            introSportRowWidget("운동 유형", _sportList.sportStep!),
            HeightBox(
              bigHeight,
            ),
            moveAndBackButton("AI와 함께 운동하기", () => goAiLearningPage(context)),
            HeightBox(
              bigHeight,
            ),
            moveAndBackButton("뒤로가기", () => goBack(context)),
            HeightBox(
              bigHeight,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox moveAndBackButton(String intro, VoidCallback voidCallback) {
    return SizedBox(
      height: 50,
      width: 400,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: voidCallback,
        child: intro.text.make(),
      ),
    );
  }

  Widget introSportRowWidget(String intro, String main) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          intro.text.size(normalFontSize + 2).make(),
          WidthBox(bigWidth),
          main.text.size(normalFontSize + 2).make()
        ],
      ),
    );
  }
}
