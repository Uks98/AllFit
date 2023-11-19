import 'dart:convert';

class RecommendSport {
  String? age;
  String? sex;
  String? disalbe_type;
  String? disable_grad;
  String? sport_step;
  String? recommend_sport;

  RecommendSport(
      { this.age,
        this.sex,
        this.disalbe_type,
        this.disable_grad,
        this.sport_step,
        this.recommend_sport,
      });

  //marker에 필요한 factory method
  factory RecommendSport.fromJson(Map<String, dynamic> json) {
    return RecommendSport(
        age: json["agrde_flag_nm"].toString(),
        sex: json["sexdstn_flag_cd"].toString(),
        disalbe_type: json["trobl_ty_nm"].toString(),
        disable_grad: json["trobl_grad_nm"].toString(),
        sport_step: json["sports_step_nm"].toString(),
        recommend_sport: json["recomend_mvm_nm"].toString());
  }
}

//로케이션 페이지 데이터 인터페이스 (마커)

class DisableSportClass {
  final List<RecommendSport>? sportList;
  DisableSportClass({this.sportList});

  factory DisableSportClass.fromJson(var jsonString) {
    List<dynamic> listJson = json.decode(jsonString);
    List<RecommendSport> sportList = <RecommendSport>[];

    sportList = listJson.map((place) => RecommendSport.fromJson(place)).toList();
    return DisableSportClass(sportList: sportList);
  }
}
