import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:fifteen_minute_diary/custom_class/post_binder.dart';
import 'package:fifteen_minute_diary/write_diary_screen/write_diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'main_peed_screen/main_peed_screen.dart';

const String _tag = 'main: ';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path)
      .then((value) => debugPrint(_tag + "Hive init"));
  Hive.registerAdapter(PostAdapter());
  await Hive.openBox<Post>(k_PostBox);
  initializeDateFormatting().then((_) => runApp(const MyApp()));
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
            binding: PostBinder()),
      ],
    );
  }
}
