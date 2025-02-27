// lib/services/cat_api_service.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// The Cat API의 검색 엔드포인트를 호출하는 서비스 클래스
class CatApiService {
  // API 키가 필요한 경우, 환경 변수에서 불러옵니다.
  // (필요하지 않다면 빈 문자열로 두세요)
  final String _apiKey = dotenv.env['CAT_API_KEY'] ?? '';

  /// 사용자가 입력한 [breed]를 기반으로 고양이 품종 정보를 검색합니다.
  /// The Cat API의 엔드포인트: /v1/breeds/search?q={breed}
  Future<Map<String, dynamic>> fetchCatInfo(String breed) async {
    // 검색 엔드포인트 URL 생성
    final String url = "https://api.thecatapi.com/v1/breeds/search?q=$breed";

    // 요청 헤더 설정, API 키가 있으면 추가
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
