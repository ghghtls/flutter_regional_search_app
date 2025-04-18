//1.상태 클래스 만들기
import 'package:flutter_regional_search_app/data/model/location.dart';
import 'package:flutter_regional_search_app/data/repository/location_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  List<Location> location;
  HomeState(this.location);
}

//2.뷰모델 만들기 -notifier 상속
class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState([]);
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
