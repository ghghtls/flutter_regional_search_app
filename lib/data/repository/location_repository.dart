import 'package:flutter_regional_search_app/data/model/location.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:http/http.dart' as client;

class LocationRepository {
  Future<List<Location>> locationSearch(String query) async {
    final client = Client();
    final response = await client.get(
      Uri.parse('https://openapi.naver.com/v1/search/local.json?query=$query'),
      headers: {
        'X-Naver-Client-Id': 'h7GUG8LSHVAS8_V2LUkE',
        'X-Naver-Client-Secret': 'XbwI_5Zfzw',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      final items = List.from(map['items']);

      final iterable = items.map((e) {
        return Location.fromJson(e);
      });

      final list = iterable.toList();
      return list;
    }
    //빈리스트 반환
    return [];
  }
}
