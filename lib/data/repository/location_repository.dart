import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_regional_search_app/data/model/location.dart';
import 'package:dio/dio.dart';

class LocationRepository {
  Future<List<Location>> locationSearch(String query) async {
    final clientId = dotenv.env['NAVER_CLIENT_ID'] ?? '';
    final clientSecret = dotenv.env['NAVER_CLIENT_SECRET'] ?? '';

    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://openapi.naver.com/v1/search/',
        headers: {
          'X-Naver-Client-Id': clientId,
          'X-Naver-Client-Secret': clientSecret,
        },
      ),
    );

    try {
      final response = await dio.get(
        'local.json',
        queryParameters: {'query': query, 'display': 5},
      );

      if (response.statusCode == 200) {
        final items = List.from(response.data['items']);
        return items.map((e) => Location.fromJson(e)).toList();
      }
    } on DioException catch (e) {
      print('Dio Error: ${e.message}');
    } catch (e) {
      print('Unknown Error: $e');
    }

    return [];
  }
}
