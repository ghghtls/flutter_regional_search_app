import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class VworldRepository {
  final Dio _client = Dio(BaseOptions(validateStatus: (status) => true));

  Future<List<String>> findByName(String query) async {
    final apiKey = dotenv.env['VWORLD_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      print('findByName: VWorld API 키가 없습니다.');
      return [];
    }

    try {
      final response = await _client.get(
        'https://api.vworld.kr/req/search',
        queryParameters: {
          'request': 'search',
          'key': apiKey,
          'query': query,
          'type': 'DISTRICT',
          'category': 'L4',
        },
      );

      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        final items = response.data['response']['result']['items'];
        return List<String>.from(items.map((item) => item['title'].toString()));
      }

      return [];
    } catch (e) {
      print(' findByName 에러: $e');
      return [];
    }
  }

  Future<List<String>> findByLatLng(double lat, double lng) async {
    final apiKey = dotenv.env['VWORLD_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      print(' findByLatLng: VWorld API 키가 없습니다.');
      return [];
    }

    print('현재 위치: 위도 $lat, 경도 $lng');

    try {
      final response = await _client.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'request': 'GetFeature',
          'key': apiKey,
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
        return List<String>.from(
          features.map((feat) => feat['properties']['full_nm'].toString()),
        );
      }

      return [];
    } catch (e) {
      print(' findByLatLng 에러: $e');
      return [];
    }
  }
}
