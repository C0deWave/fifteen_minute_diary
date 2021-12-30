import 'package:fifteen_minute_diary/write_diary_screen/write_diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'controller/post_controller.dart';
import 'main_peed_screen/main_peed_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '15분 일기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MainPeedScreen(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const MainPeedScreen()),
        GetPage(
            name: '/writepage',
            page: () => const WriteDiaryScreen(),
            binding: PostBinding()),
      ],
    );
  }
}
