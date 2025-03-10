import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cat_controller.dart';
import '../models/cat_model.dart';

//GetView<CatController>를 상속받음
class FavoritesView extends GetView<CatController> {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("즐겨찾기"),
      ),
      // Obx 위젯을 통해 favorites 리스트가 변경될 때마다 UI 업데이트
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return const Center(
            child: Text(
              "즐겨찾기에 추가된 품종이 없습니다.",
              style: TextStyle(fontSize: 16),
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            CatModel cat = controller.favorites[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(cat.breed),
                subtitle: Text(cat.description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    controller.removeFavorite(cat);
                    Get.snackbar(
                      "삭제",
                      "${cat.breed} 즐겨찾기에서 삭제되었습니다.",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
