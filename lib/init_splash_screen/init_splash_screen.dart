import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/init_splash_screen/component/page_model_list.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitSplashScreen extends StatefulWidget {
  const InitSplashScreen({Key? key}) : super(key: key);

  @override
  _InitSplashScreenState createState() => _InitSplashScreenState();
}

class _InitSplashScreenState extends State<InitSplashScreen> {
  @override
  Widget build(BuildContext context) {
    String _tag = 'init_splash_screen: ';

    // WillPopScope 는 backSwipe를 막아줍니다.
    return WillPopScope(
      onWillPop: () async => false,
      child: IntroductionScreen(
        animationDuration: 200,
        pages: listPagesViewModel,
        onDone: () async {
          debugPrint(_tag + 'shared_preference 데이터 저장');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(k_IsViewSplashViewKey, true);
          // Navigator.pop(context);
          Get.back();
        },
        onSkip: () async {
          debugPrint(_tag + 'shared_preference 데이터 저장');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(k_IsViewSplashViewKey, true);
          // Navigator.pop(context);
          Get.back();
        },
        showSkipButton: true,
        skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
        next: const Text("Next", style: TextStyle(fontWeight: FontWeight.w600)),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.black45,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 4.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
