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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("15Minute Diary")),
        ],
      ),
    );
  }
}
