
abstract interface class LocationPlaceListProvider {

  ///공통되는 함수를 interface로 분리해 재사용성을 높이고 중복성을 줄였습니다
  ///키워드에 포함되는 리스트를 불러옵니다.
  void getLocationPlaceList(String location);


  /// 전국에 장애인 운동시설 정보를 불러옵니다.
  Future<void> getDisableClass();

  ///전체 버튼 클릭 시 리스트를 초기화하는 함수입니다.
  void showAllLocations();
}