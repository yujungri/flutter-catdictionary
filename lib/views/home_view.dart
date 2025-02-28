import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cat_controller.dart';

class HomeView extends GetView<CatController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("고양이 사전"),
        actions: [
          // 즐겨찾기 화면으로 이동하는 아이콘 버튼
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // GetX의 라우트 기능으로 즐겨찾기 화면으로 이동
              Get.toNamed('/favorites');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 사용자로부터 고양이 품종 입력을 받는 TextField
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "고양이 품종 입력",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // 검색 버튼을 누르면 컨트롤러의 fetchCatBreedInfo 메서드 호출
            ElevatedButton(
              onPressed: () {
                if (searchController.text.isNotEmpty) {
                  // GetView를 사용하면, 'controller' 프로퍼티로 CatController에 접근할 수 있음
                  controller.fetchCatBreedInfo(searchController.text);
                }
              },
              child: const Text("검색"),
            ),
            const SizedBox(height: 20),
            // Obx 위젯을 통해 컨트롤러의 상태가 변경될 때마다 UI를 자동 갱신
            Obx(() {
              if (controller.isLoading.value) {
                // API 호출 중 로딩 인디케이터 표시
                return const CircularProgressIndicator();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "검색 결과:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // 컨트롤러의 currentCatInfo observable 값을 이용해 검색 결과 출력
                  Text(
                    "품종: ${controller.currentCatInfo.value.breed}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "설명: ${controller.currentCatInfo.value.description}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  // 즐겨찾기에 추가하는 버튼
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.addCurrentToFavorites();
                      // 즐겨찾기 추가 후 스낵바를 통해 사용자에게 알림
                      Get.snackbar(
                        "즐겨찾기",
                        "해당 품종이 즐겨찾기에 추가되었습니다.",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    icon: const Icon(Icons.favorite_border),
                    label: const Text("즐겨찾기에 추가"),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
