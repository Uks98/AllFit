import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_care_ml_app/model/health_recommend_data.dart';
import 'package:velocity_x/velocity_x.dart';

import '../base_app_color_and_font/constant_widget.dart';
import '../widget/SelectedListClass.dart';

class SelectHealthCarePage extends StatefulWidget {
  const SelectHealthCarePage({super.key});

  @override
  State<SelectHealthCarePage> createState() => _SelectHealthCarePageState();
}

class _SelectHealthCarePageState extends State<SelectHealthCarePage> {
  List<RecommendSport> sportList = [];
  List<RecommendSport> filteredSportList = [];
  List<String> ageList = ["10대", "20대", "30대", "40대"];
  List<String> disableType = ["지적장애", "청각장애", "척수장애", "시각장애"];
  List<String> disableGrad = ["1등급", "2등급", "3등급", "4등급","완전 마비"];
  List<String> sportStep = ["준비운동", "본운동", "마무리운동"];

  int ageIndex = 0;
  String ageText = "";
  int disableTypeIndex = 0;
  String disableTypeText = "";
  int disableGradIndex = 0;
  String disableGradText = "";
  int sportStepIndex = 0;
  String sportStepText = "";

  Future<void> getSportList() async {
    final routeFromJsonFile = await rootBundle.loadString(
        'lib/json/KS_DSPSN_FTNESS_MESURE_ACCTO_RECOMEND_MVM_INFO_202304.json');
    sportList = DisableSportClass.fromJson(routeFromJsonFile).sportList ??
        <RecommendSport>[];
    print("ss${sportList}");

    setState(() {});
  }

  void recommendSport(String age, String type, String grad, String step) {
    filteredSportList = sportList
        .where((sport) =>
            sport.age!.contains(age) &&
            sport.disalbe_type!.contains(type) &&
            sport.disable_grad!.contains(grad) &&
            sport.disable_grad!.contains(step))
        .toList();
    // filteredSportList = sportList
    //     .where((sport) =>
    // sport.age!.contains("10대") &&
    //     sport.disalbe_type!.contains(type))
    //     .toList();

    // print(age);
    // print(type);
    // print(grad);
    print(filteredSportList);
    for(final x in filteredSportList){
      print("추천 운동        ${x.age}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSportList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "어떤 운동을 선호 하세요?"
                .text
                .fontWeight(FontWeight.bold)
                .size(normalFontSize + 2)
                .make(),
            "분야별 목표에 맞게 운동을 추천해드려요!"
                .text
                .color(Colors.grey[600])
                .size(smallFontSize)
                .make(),
            "연령대".text.size(normalFontSize).fontWeight(FontWeight.bold).make(),
            SelectedList(
              selectIndex: ageIndex,
              selectedText: ageText,
              list: ageList,
            ),
            "장애유형".text.size(normalFontSize).fontWeight(FontWeight.bold).make(),
            SelectedList(
              selectIndex: disableTypeIndex,
              selectedText: disableTypeText,
              list: disableType,
            ),
            "장애등급".text.size(normalFontSize).fontWeight(FontWeight.bold).make(),
            SelectedList(
              selectIndex: disableGradIndex,
              selectedText: disableGradText,
              list: disableGrad,
            ),
            "운동 단계"
                .text
                .size(normalFontSize)
                .fontWeight(FontWeight.bold)
                .make(),
            SelectedList(
              selectIndex: sportStepIndex,
              selectedText: sportStepText,
              list: sportStep,
            ),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        recommendSport(
                          ageText,disableTypeText,disableGradText,sportStepText,
                        );
                        setState(() {});
                      },
                      child: "나에게 꼭 맞는 운동 추천 받기"
                          .text
                          .fontWeight(FontWeight.bold)
                          .make()),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
