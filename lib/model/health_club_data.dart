import 'dart:convert';

class DisableClubInfo {
  String? classType;
  String? classLocation;
  String? signguNM;
  String? classNM;
  String? disableType;
  String? operateTime;
  String? detailInfo;

  DisableClubInfo(
      { this.classType,
        this.classLocation,
        this.signguNM,
        this.classNM,
        this.disableType,
        this.operateTime,
        this.detailInfo,
        });

  //marker에 필요한 factory method
  factory DisableClubInfo.fromJson(Map<String, dynamic> json) {
    return DisableClubInfo(
        classType: json["item_nm"].toString(),
        classLocation: json["ctprvn_nm"].toString(),
        signguNM: json["signgu_nm"].toString(),
        classNM: json["club_nm"].toString(),
        disableType: json["trobl_ty_nm"].toString(),
        operateTime: json["oper_time_cn"].toString(),
        detailInfo: json["club_intrcn_cn"].toString());
  }
}

//로케이션 페이지 데이터 인터페이스 (마커)

class DisableClub {
  final List<DisableClubInfo>? disableClub;
  DisableClub({this.disableClub});

  factory DisableClub.fromJson(var jsonString) {
    List<dynamic> listFromJson = json.decode(jsonString);
    List<DisableClubInfo> places = <DisableClubInfo>[];

    places = listFromJson.map((place) => DisableClubInfo.fromJson(place)).toList();
    return DisableClub(disableClub: places);
  }
}
