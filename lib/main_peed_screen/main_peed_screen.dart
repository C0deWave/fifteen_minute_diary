// ignore_for_file: avoid_print

import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/init_splash_screen/init_splash_screen.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/main_peed_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/main_peed_body.dart';

class MainPeedScreen extends StatelessWidget {
  const MainPeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkData(context);
    return Scaffold(
      appBar: mainPeedAppBar,
      body: const MainPeedBody(),
      // ignore: todo
      //TODO 사이드바 추후 개선하기
      drawer: Drawer(
        backgroundColor: Colors.green,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 80,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: SafeArea(child: Text('사이드바 입니다.')),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }

  // 스플래시를 보지 않았을 경우 스플래시 설명화면으로 이동
  void checkData(var context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isViewSplash = prefs.getBool(k_IsViewSplashViewKey) ?? false;
    if (!isViewSplash) {
      if (k_DebugMode) {
        print('Splash이동');
      }
      Get.to((_) => const InitSplashScreen());
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const InitSplashScreen()));
    }
  }
}
