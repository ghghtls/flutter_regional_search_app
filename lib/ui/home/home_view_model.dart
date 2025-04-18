//1.상태 클래스 만들기
import 'package:flutter_regional_search_app/data/model/location.dart';
import 'package:flutter_regional_search_app/data/repository/location_repository.dart';
import 'package:flutter_regional_search_app/data/repository/vworld_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class HomeState {
  List<Location> location;
  HomeState(this.location);
}

//2.뷰모델 만들기 -notifier 상속
class HomeViewModel extends Notifier<HomeState> {
  final locationRepository = LocationRepository();
  final vworldRepository = VworldRepository();
  @override
  HomeState build() {
    return HomeState([]);
  }

  Future<void> searchFromCurrentLatLng() async {
    try {
      // 서울시청 좌표를 직접 지정
      final lat = 37.5665;
      final lng = 126.9780;

      print('사용자 위치 (서울시청 고정): 위도 $lat, 경도 $lng');

      final addressList = await vworldRepository.findByLatLng(lat, lng);

      if (addressList.isEmpty) {
        print('VWorld로부터 주소를 찾을 수 없습니다.');
        return;
      }

      final keyword = addressList.first;
      final result = await locationRepository.locationSearch(keyword);
      state = HomeState(result); // 상태 업데이트

      print('현재 위치 주소: $keyword');
      print('검색 결과 수: ${result.length}');
    } catch (e) {
      print('searchFromCurrentLatLng 에러: $e');
    }
  }

  Future<void> locationSearch(String query) async {
    final locationRepository = LocationRepository();
    final location = await locationRepository.locationSearch(query);
    state = HomeState(location);
  }
}

//3. 뷰모델 관리자 만들기 -notifireProvider 객체
final HomeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});
