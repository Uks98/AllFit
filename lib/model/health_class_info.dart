import 'dart:convert';

class DisableClassInfo {
  String? classType;
  String? classLocation;
  String? signguNM;
  String? classNM;
  String? disableType;
  String? operateTime;
  String? recruitmentData;//모집기간
  String? operateData; //운영기간

  DisableClassInfo(
      { this.classType,
        this.classLocation,
        this.signguNM,
        this.classNM,
        this.disableType,
        this.operateTime,
        this.recruitmentData,
        this.operateData,
      });

  //marker에 필요한 factory method
  factory DisableClassInfo.fromJson(Map<String, dynamic> json) {
    return DisableClassInfo(
        classType: json["item_nm"].toString(),
        classLocation: json["ctprvn_nm"].toString(),
        signguNM: json["signgu_nm"].toString(),
        classNM: json["clssrm_nm"].toString(),
        disableType: json["trobl_ty_nm"].toString(),
        operateTime: json["oper_time_cn"].toString(),
        recruitmentData: json["rcrit_pd"].toString(),
         operateData: json["oper_pd"].toString());
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
