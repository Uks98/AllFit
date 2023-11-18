import 'dart:convert';

class DisableClassInfo {
  String? class_type;
  String? class_location;
  String? signgu_nm;
  String? class_nm;
  String? disable_type;
  String? operate_time;
  String? recruitment_date;//모집기간
  String? operate_date; //운영기간

  DisableClassInfo(
      { this.class_type,
        this.class_location,
        this.signgu_nm,
        this.class_nm,
        this.disable_type,
        this.operate_time,
        this.recruitment_date,
        this.operate_date,
      });

  //marker에 필요한 factory method
  factory DisableClassInfo.fromJson(Map<String, dynamic> json) {
    return DisableClassInfo(
        class_type: json["item_nm"].toString(),
        class_location: json["ctprvn_nm"].toString(),
        signgu_nm: json["signgu_nm"].toString(),
        class_nm: json["clssrm_nm"].toString(),
        disable_type: json["trobl_ty_nm"].toString(),
        operate_time: json["oper_time_cn"].toString(),
        recruitment_date: json["rcrit_pd"].toString(),
         operate_date: json["oper_pd"].toString());
  }
}

//로케이션 페이지 데이터 인터페이스 (마커)

class DisableClass {
  final List<DisableClassInfo>? disableClassList;
  DisableClass({this.disableClassList});

  factory DisableClass.fromJson(var jsonString) {
    List<dynamic> listJson = json.decode(jsonString);
    List<DisableClassInfo> places1 = <DisableClassInfo>[];

    places1 = listJson.map((place) => DisableClassInfo.fromJson(place)).toList();
    return DisableClass(disableClassList: places1);
  }
}
