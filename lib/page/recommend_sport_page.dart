import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:health_care_ml_app/page/detail_sport_page.dart';
import 'package:velocity_x/velocity_x.dart';
import '../base_app_color_and_font/constant_widget.dart';
import '../model/health_recommend_data.dart';

class RecommendSportPage extends StatelessWidget {
  List<RecommendSport> sportList = [];
   RecommendSportPage({super.key,required this.sportList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeightBox(50),
            sportList.isEmpty ? noDataBackToPreviousPage(context) : "다음 운동을 추천해요!".text.size(20).fontWeight(FontWeight.w500).make(),
            Expanded(
              child: AnimationLimiter(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1300),
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
                                    onTap: ()=>
                                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailSportPage(recommendSport: sportList[index],),),),
                                    hoverColor: Colors.grey[200],
                                    contentPadding: EdgeInsets.only(left: normalWidth),
                                    title: sportList[index].recommendSport?.text.fontWeight(FontWeight.w500).size(normalFontSize - 1).make() ?? "종목 없음".text.make(),
                                    subtitle: sportList[index].disableType?.text.color(Colors.grey[700]).size(smallFontSize).make() ?? "종목 없음".text.make(),),
                                ),
                              ),
                            ),
                          ),
                        );
                    },
                    separatorBuilder: (ctx, idx) {
                      return HeightBox(normalHeight);
                    },
                    itemCount: sportList.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column noDataBackToPreviousPage(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child:"데이터가 존재하지 않습니다. 유형을 다시 확인해주세요.".text.make(),),
              MaterialButton(onPressed: () => Navigator.of(context).pop(),child: "뒤로가기".text.make(),)
            ],
          );
  }
}
