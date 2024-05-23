import 'dart:convert';

class RecommendSport {
  String? age;
  String? sex;
  String? disableType;
  String? disableGrad;
  String? sportStep;
  String? recommendSport;

  RecommendSport(
      { this.age,
        this.sex,
        this.disableType,
        this.disableGrad,
        this.sportStep,
        this.recommendSport,
      });

  //marker에 필요한 factory method
  factory RecommendSport.fromJson(Map<String, dynamic> json) {
    return RecommendSport(
        age: json["agrde_flag_nm"].toString(),
        sex: json["sexdstn_flag_cd"].toString(),
        disableType: json["trobl_ty_nm"].toString(),
        disableGrad: json["trobl_grad_nm"].toString(),
        sportStep: json["sports_step_nm"].toString(),
        recommendSport: json["recomend_mvm_nm"].toString());
  }
}


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
