import 'package:flutter_regional_search_app/data/model/location.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as client;

class LocationRepository {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://openapi.naver.com/v1/search/',
      headers: {
        'X-Naver-Client-Id': 'h7GUG8LSHVAS8_V2LUkE',
        'X-Naver-Client-Secret': 'XbwI_5Zfzw',
      },
    ),
  );
  Future<List<Location>> locationSearch(String query) async {
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
