import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:velocity_x/velocity_x.dart';
import '../base_app_color_and_font/constant_widget.dart';
import '../model/health_recommend_data.dart';
import 'club_detail_page.dart';

class RecommendSportPage extends StatelessWidget {
  List<RecommendSport> sportList = [];
   RecommendSportPage({super.key,required this.sportList});

  @override
  Widget build(BuildContext context) {
    print(sportList);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            "다음 운동을 추천해요!".text.size(20).fontWeight(FontWeight.w500).make(),
            Expanded(
              child: AnimationLimiter(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return
                        AnimationConfiguration.staggeredList(
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
                                    onTap: (){
                                      // showModalBottomSheet(
                                      //   context: context,
                                      //   builder: (BuildContext context) {
                                      //     return ClubDetailPage(disableClubInfo: sportList[index],); // 위에서 만든 CustomBottomSheet 위젯을 호출합니다.
                                      //   },
                                      // );
                                    },
                                    hoverColor: Colors.grey[200],
                                    contentPadding: EdgeInsets.only(left: 20),
                                    title: sportList[index].recommend_sport?.text.fontWeight(FontWeight.w500).size(normalFontSize - 1).make(),
                                    subtitle: sportList[index].disalbe_type!.text.color(Colors.grey[700]).size(smallFontSize).make(),),
                                ),
                              )
                            ),
                          ),
                        );

                    },
                    separatorBuilder: (ctx, idx) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: sportList.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
