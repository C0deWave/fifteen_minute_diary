import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/init_splash_screen/init_splash_screen.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/drawer_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/main_peed_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/main_peed_body.dart';

class MainPeedScreen extends StatelessWidget {
  final String _tag = 'MainPeedScreen: ';
  const MainPeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkData(context);
    return Scaffold(
        appBar: mainPeedAppBar,
        body: const MainPeedBody(),
        drawer: const DrawerWidget());
  }

  // 스플래시를 보지 않았을 경우 스플래시 설명화면으로 이동
  void checkData(var context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isViewSplash = prefs.getBool(k_IsViewSplashViewKey) ?? false;
    if (!isViewSplash) {
      debugPrint(_tag + 'Splash이동');
      Get.to(InitSplashScreen());
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const InitSplashScreen()));
    }
  }
}
