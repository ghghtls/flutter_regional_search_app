import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class VworldRepository {
  final Dio _client = Dio(
    BaseOptions(
      // 설정안할 시 실패 응답오면 throw 던져서 에러남
      validateStatus: (status) => true,
    ),
  );

  //위도 경도로 검색하는 기능
  Future<List<String>> findByLatLng(double lat, double lng) async {
    try {
      final response = await _client.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'request': 'GetFeature',
          'key': dotenv.env['key'],
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
        final iterable = featureList.map((feat) {
          return '${feat['properties']['full_nm']}';
        });
        return iterable.toList();
      }

      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
