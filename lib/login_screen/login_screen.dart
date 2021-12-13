import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/init_splash_screen/init_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _tag = 'login_screen:';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (true) {
    //   return const InitSplashScreen();
    // }
    checkData(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("15Minute Diary")),
        ],
      ),
    );
  }

  // 스플래시를 보지 않았을 경우 스플래시 설명화면으로 이동
  void checkData(var context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isViewSplash = prefs.getBool(isViewSplashView_Key) ?? false;
    if (!isViewSplash) {
      if (kDebugMode) {
        print('$_tag Splash이동');
      }
      Get.to(InitSplashScreen());
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const InitSplashScreen()));
    }
  }
}
