import 'package:get/get.dart';
import 'controllers/cat_controller.dart';

/// 앱 실행 시 필요한 의존성
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // CatController를 전역에서 사용
    Get.put(CatController());
  }
}
