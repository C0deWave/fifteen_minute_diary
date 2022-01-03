import 'dart:io';

import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/controller/timer_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/timer_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/timer_complete_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeroTimerWidget extends StatelessWidget {
  const HeroTimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerController = Get.put(TimerController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Hero(
          tag: k_TimerHerotag,
          child: TimerWidget(callback: () async {
            Get.dialog(!Platform.isIOS
                ? await TimerCompleteAlert.androidWriteCheckAlert(
                    context, timerController)
                : await TimerCompleteAlert.iosWriteCheckAlert(
                    context, timerController));
          })),
    );
  }
}
