import 'dart:convert';

class DisableClubInfo {
  String? class_type;
  String? class_location;
  String? signgu_nm;
  String? club_nm;
  String? disable_type;
  String? operate_time;
  String? detail_info;

  DisableClubInfo(
      { this.class_type,
        this.class_location,
        this.signgu_nm,
        this.club_nm,
        this.disable_type,
        this.operate_time,
        this.detail_info,
        });

  //marker에 필요한 factory method
  factory DisableClubInfo.fromJson(Map<String, dynamic> json) {
    return DisableClubInfo(
        class_type: json["item_nm"].toString(),
        class_location: json["ctprvn_nm"].toString(),
        signgu_nm: json["signgu_nm"].toString(),
        club_nm: json["club_nm"].toString(),
        disable_type: json["trobl_ty_nm"].toString(),
        operate_time: json["oper_time_cn"].toString(),
        detail_info: json["club_intrcn_cn"].toString());
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
