import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

//API 엔드포인트 호출
class CatApiService {
  final String _apiKey = dotenv.env['CAT_API_KEY'] ?? '';

  // 엔드포인트: /v1/breeds/search?q={breed}
  // 이미지는 v1/images/search")
  Future<Map<String, dynamic>> fetchCatInfo(String breed) async {
    // 검색 엔드포인트 URL 생성
    final String url = "https://api.thecatapi.com/v1/breeds/search?q=$breed";

    final headers = {
      "Content-Type": "application/json",
      if (_apiKey.isNotEmpty) "x-api-key": _apiKey,
    };

    // HTTP GET 요청
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body);
      if (result.isNotEmpty) {
        // 첫 번째 결과 반환
        return result[0] as Map<String, dynamic>;
      } else {
        throw Exception("검색 결과가 없습니다.");
      }
    } else {
      throw Exception("The Cat API 호출 실패: ${response.statusCode}");
    }
  }
}
