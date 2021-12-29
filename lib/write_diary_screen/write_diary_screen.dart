import 'dart:io';

import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/timer_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/main_peed_screen.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/context_textfield_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/hero_timer_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/title_textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

import '../controller/timer_controller.dart';

class WriteDiaryScreen extends StatelessWidget {
  const WriteDiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: RotationTransition(
              turns: AlwaysStoppedAnimation((315 / 360)),
              child: Icon(Icons.send)),
          onPressed: () {},
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: const [
                HeroTimerWidget(),
                TitleTextFieldWidget(),
                ContextTextFieldWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
