import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:health_care_ml_app/color/color_box.dart';
import 'package:health_care_ml_app/model/health_recommend_data.dart';
import 'package:health_care_ml_app/page/recommend_sport_page.dart';
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
  List<String> disableGrad = ["1등급", "2등급", "3등급", "4등급", "완전 마비"];
  List<String> sportStep = ["준비운동", "본운동", "마무리운동"];

  int ageIndex = 0;
  int disableTypeIndex = 0;
  int disableGradIndex = 0;
  int sportStepIndex = 0;
  String ageText = "";
  String disableTypeText = "";
  String disableGradText = "";
  String sportStepText = "";

  Future<void> getSportList() async {
    final routeFromJsonFile = await rootBundle.loadString(
        'lib/json/KS_DSPSN_FTNESS_MESURE_ACCTO_RECOMEND_MVM_INFO_202304.json');
    sportList = DisableSportClass.fromJson(routeFromJsonFile).sportList ??
        <RecommendSport>[];
    setState(() {});
  }

  void recommendSport(String? age, String? type, String? grad, String? step) {
    if (age == null || type == null || grad == null || step == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: "죄송합니다. 에러가 발생했습니다. 다시 시도해주세요".text.make(),
        ),
      );
    }
    filteredSportList = sportList
        .where((sport) =>
            sport.age!.contains(age!) &&
            sport.disableType!.contains(type!) &&
            sport.disableGrad!.contains(grad!) &&
            sport.sportStep!.contains(step!))
        .toList();
  }

  void getRecommendTypeForDisable(
    String ageText,
    String disableTypeText,
    String disableGradText,
    String sportStepText,
  ) {
    recommendSport(
      ageText,
      disableTypeText,
      disableGradText,
      sportStepText,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("나에게 알맞은 운동을 찾고있어요 잠시만요!"),
      ),
    );
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RecommendSportPage(
            sportList: filteredSportList,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getSportList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.only(left: normalWidth, top: 30, right: normalWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "현재 상태를 선택해주세요"
                  .text
                  .fontWeight(FontWeight.w500)
                  .size(normalFontSize + 7)
                  .make(),
              HeightBox(normalHeight),
              "내 몸에 맞는 운동을 찾아드릴게요!"
                  .text
                  .color(Colors.grey[600])
                  .fontWeight(FontWeight.w500)
                  .size(smallFontSize + 5)
                  .make(),
              HeightBox(bigHeight + 20),
              "연령대"
                  .text
                  .size(normalFontSize)
                  .fontWeight(FontWeight.w500)
                  .make(),
              HeightBox(normalHeight),
              SizedBox(
                width: 400,
                height: 40,
                child: AnimationLimiter(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 300),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: SlideAnimation(
                                child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  ageIndex = index;
                                  ageText = ageList[index];
                                });
                              },
                              child: Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  color: ageIndex == index
                                      ? ColorBox.ageSelectColor
                                      : ColorBox.unSelectColor,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                    child: ageList[index]
                                        .text
                                        .size(smallFontSize)
                                        .make()),
                              ),
                            )),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return WidthBox(smallWidth);
                      },
                      itemCount: ageList.length),
                ),
              ),
              HeightBox(normalHeight),
              "장애유형"
                  .text
                  .size(normalFontSize)
                  .fontWeight(FontWeight.w500)
                  .make(),
              HeightBox(normalHeight),
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
                                  disableTypeIndex = index;
                                  disableTypeText = disableType[index];
                                });
                              },
                              child: Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  color: disableTypeIndex == index
                                      ? ColorBox.typeSelectColor
                                      : ColorBox.unSelectColor,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                    child: disableType[index]
                                        .text
                                        .size(smallFontSize)
                                        .make()),
                              ),
                            )),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return WidthBox(smallWidth);
                      },
                      itemCount: disableType.length),
                ),
              ),
              HeightBox(normalHeight),
              "장애등급"
                  .text
                  .size(normalFontSize)
                  .fontWeight(FontWeight.w500)
                  .make(),
              SizedBox(
                height: normalHeight,
              ),
              SizedBox(
                width: 400,
                height: 40,
                child: AnimationLimiter(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 800),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: SlideAnimation(
                                child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  disableGradIndex = index;
                                  disableGradText = disableGrad[index];
                                });
                              },
                              child: Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  color: disableGradIndex == index
                                      ? ColorBox.gradSelectColor
                                      : ColorBox.unSelectColor,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                    child: disableGrad[index]
                                        .text
                                        .size(smallFontSize)
                                        .make()),
                              ),
                            )),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return WidthBox(smallWidth);
                      },
                      itemCount: disableGrad.length),
                ),
              ),
              SizedBox(
                height: normalHeight,
              ),
              "운동 단계"
                  .text
                  .size(normalFontSize)
                  .fontWeight(FontWeight.w500)
                  .make(),
              HeightBox(normalWidth),
              SizedBox(
                width: 400,
                height: 40,
                child: AnimationLimiter(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1000),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: SlideAnimation(
                                child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sportStepIndex = index;
                                  sportStepText = sportStep[index];
                                });
                              },
                              child: Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  color: sportStepIndex == index
                                      ? ColorBox.stepSelectColor
                                      : ColorBox.unSelectColor,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                    child: sportStep[index]
                                        .text
                                        .size(smallFontSize)
                                        .make()),
                              ),
                            ),),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return WidthBox(smallWidth);
                      },
                      itemCount: sportStep.length),
                ),
              ),
              HeightBox(
                bigHeight + 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: bigHeight + 30,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(ColorBox.selectButtonColor),
                        ),
                        onPressed: () => getRecommendTypeForDisable(ageText, disableTypeText, disableGradText, sportStepText),
                        child: "나에게 꼭 맞는 운동 추천 받기"
                            .text
                            .fontWeight(FontWeight.w500)
                            .make(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
