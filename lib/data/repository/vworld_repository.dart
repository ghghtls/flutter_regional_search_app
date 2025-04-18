import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class VworldRepository {
  final Dio _client = Dio(
    BaseOptions(
      // 설정안할 시 실패 응답오면 throw 던져서 에러남
      validateStatus: (status) => true,
    ),
  );
  // 1. 이름으로 검색하는 기능
  Future<List<String>> findByName(String query) async {
    try {
      final response = await _client.get(
        'https://api.vworld.kr/req/search',
        queryParameters: {
          'request': 'search',
          'key': '06F3B570-B600-33DA-AA37-2A55E20A52E4',
          'query': query,
          'type': 'DISTRICT',
          'category': 'L4',
        },
      );
      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        // Response > result > items >> title
        final items = response.data['response']['result']['items'];
        final itemList = List.from(items);
        final iterable = itemList.map((item) {
          return '${item['title']}';
        });
        return iterable.toList();
      }

      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  // 2. 위도 경도로 검색하는 기능
  Future<List<String>> findByLatLng(double lat, double lng) async {
    print('현재 위치: $lat, $lng');

    try {
      final response = await _client.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'request': 'GetFeature',
          'key': '06F3B570-B600-33DA-AA37-2A55E20A52E4',
          'data': 'LT_C_ADEMD_INFO',
          'geomFilter': 'POINT($lng $lat)',
          'geometry': false,
          'size': 100,
        },
      );

      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        final features =
            response
                .data['response']['result']['featureCollection']['features'];
        final featureList = List.from(features);
        final result =
            featureList
                .map((feat) => feat['properties']['full_nm'].toString())
                .toList();
        return result;
      }

      return [];
    } catch (e) {
      print('findByLatLng 에러: $e');
      return [];
    }
  }
}
