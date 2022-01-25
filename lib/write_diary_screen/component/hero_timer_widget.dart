import 'dart:io';

import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/controller/calendar_controller.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/controller/timer_controller.dart';
import 'package:fifteen_minute_diary/custom_class/dialog_list.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/timer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeroTimerWidget extends StatelessWidget {
  const HeroTimerWidget({Key? key}) : super(key: key);

  yesAction() {
    TimerController timerController = Get.find<TimerController>();
    Get.find<PostController>()
        .addPostList(writeDuration: timerController.getDuration())
        .then(
            (value) => Get.find<CalendarController>().updateCalenderPostlist());
    timerController.stopTimer();
    Get.back();
    Get.back();
  }

  noAction() => Get.back();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Hero(
          tag: k_TimerHerotag,
          child: TimerWidget(callback: () {
            !Platform.isIOS
                ? DialogList.androidWriteCheckAlert(
                    context: context, yesAction: yesAction, noAction: noAction)
                : DialogList.iosWriteCheckAlert(
                    context: context, yesAction: yesAction, noAction: noAction);
          })),
    );
  }
}
