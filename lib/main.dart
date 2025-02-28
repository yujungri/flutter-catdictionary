import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'bindings.dart';
import 'views/home_view.dart';
import 'views/favorites_view.dart';

Future<void> main() async {
  // 환경 변수(.env) 파일 로드 (API 키가 필요한 경우)
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "고양이 사전",
      initialBinding: AppBindings(), // 앱 시작 시 의존성 등록
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      getPages: [
        // 즐겨찾기 화면 라우트 등록
        GetPage(name: '/favorites', page: () => FavoritesView()),
      ],
    );
  }
}
