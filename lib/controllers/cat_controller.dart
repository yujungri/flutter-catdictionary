import 'package:get/get.dart';
import '../models/cat_model.dart';
import '../services/cat_api_service.dart';

//고양이 품종 정보를 검색, 즐겨찾기 목록을 관리
class CatController extends GetxController {
  final CatApiService _catApiService = CatApiService();

  // 현재 검색 결과를 저장 (기본적으로 빈 값으로 초기화)
  var currentCatInfo = CatModel(breed: '', description: '').obs;
  // API 호출 중 로딩 상태
  var isLoading = false.obs;
  // 사용자가 즐겨찾기에 추가한 품종 목록
  var favorites = <CatModel>[].obs;

  /// 사용자가 입력한 [breed]에 대해 The Cat API에서 정보를 가져옵니다.
  Future<void> fetchCatBreedInfo(String breed) async {
    isLoading.value = true;
    try {
      // API 호출하여 결과 데이터 가져오기
      final data = await _catApiService.fetchCatInfo(breed);
      // data에서 필요한 정보 추출 (이름과 설명)
      String name = data['name'] ?? '알 수 없음';
      String description = data['description'] ?? '설명 없음';
      // 현재 검색 결과 업데이트 (UI 자동 반영)
      currentCatInfo.value = CatModel(breed: name, description: description);
    } catch (e) {
      // 오류 발생 시 에러 메시지
      currentCatInfo.value =
          CatModel(breed: breed, description: "정보를 가져오지 못했습니다: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// 현재 검색 결과를 즐겨찾기에 추가합니다.
  void addCurrentToFavorites() {
    if (currentCatInfo.value.breed.isEmpty) return;
    favorites.add(currentCatInfo.value);
  }

  /// 즐겨찾기 목록에서 특정 항목을 제거합니다.
  void removeFavorite(CatModel cat) {
    favorites.remove(cat);
  }
}
