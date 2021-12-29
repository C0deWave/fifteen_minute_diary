import 'dart:io';

import 'package:fifteen_minute_diary/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/timer_controller.dart';
import '../../main_peed_screen/component/timer_widget.dart';
import '../../main_peed_screen/main_peed_screen.dart';

class HeroTimerWidget extends StatelessWidget {
  const HeroTimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerController = Get.put(TimerController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Hero(
          tag: k_timer_herotag,
          child: TimerWidget(callback: () async {
            Get.dialog(!Platform.isIOS
                ? await androidWriteCheckAlert(context, timerController)
                : await iosWriteCheckAlert(context, timerController));
          })),
    );
  }

  Future<dynamic> iosWriteCheckAlert(
      BuildContext context, TimerController timerController) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(k_alert_title),
        content: Text(k_alert_content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(k_alert_yes),
            onPressed: () => Get.offAll(MainPeedScreen()),
          ),
          CupertinoDialogAction(
            child: Text(k_alert_no),
            onPressed: () => Get.back(),
          ),
          CupertinoDialogAction(
              child: Text(k_alert_cancle),
              onPressed: () {
                timerController.resetTimer();
                Get.offAll(MainPeedScreen());
              }),
        ],
      ),
    );
  }

  Future<dynamic> androidWriteCheckAlert(
      BuildContext context, TimerController timerController) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(k_alert_title),
        content: Text(k_alert_content),
        actions: <Widget>[
          TextButton(
            child: Text(k_alert_yes),
            onPressed: () => Get.offAll(MainPeedScreen()),
          ),
          TextButton(
            child: Text(k_alert_no),
            onPressed: () => Get.back(),
          ),
          TextButton(
              child: Text(k_alert_cancle),
              onPressed: () {
                timerController.resetTimer();
                Get.offAll(MainPeedScreen());
              }),
        ],
      ),
    );
  }
}
