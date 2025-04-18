import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_regional_search_app/data/model/location.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class LocationRepository {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://openapi.naver.com/v1/search/',
      headers: {
        'X-Naver-Client-Id': '_qoNMygDh0Ytq3YJozlo',
        'X-Naver-Client-Secret': 'L6yxGm2a8F',
      },
    ),
  );
  Future<List<Location>> locationSearch(String query) async {
    print('네이버 헤더: ${dio.options.headers}');
    try {
      final response = await dio.get(
        'local.json',
        queryParameters: {'query': query, 'display': 5},
        options: Options(
          headers: {
            'X-Naver-Client-Id': '_qoNMygDh0Ytq3YJozlo',
            'X-Naver-Client-Secret': 'L6yxGm2a8F',
          },
        ),
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
