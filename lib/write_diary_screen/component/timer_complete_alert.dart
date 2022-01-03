import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/controller/timer_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/main_peed_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerCompleteAlert {
  static Future<dynamic> iosWriteCheckAlert(
      BuildContext context, TimerController timerController) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text(k_AlertTitle),
        content: Text(k_AlertContent1 +
            Get.find<TimerController>().getCurrentTime() +
            k_AlertContent2),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text(k_AlertYes),
            onPressed: () {
              // ignore: todo
              //TODO: 게시글 저장 구현하기
              Get.find<PostController>().addPostList(
                  timerController.getWriteDate(),
                  timerController.getDuration());
              timerController.resetTimer();
              Get.back();
              Get.back();
            },
          ),
          CupertinoDialogAction(
            child: const Text(k_AlertNo),
            onPressed: () => Get.back(),
          ),
          CupertinoDialogAction(
              child: const Text(k_AlertCancle),
              onPressed: () {
                timerController.resetTimer();
                Get.find<PostController>().resetWriteState();
                Get.back();
                Get.back();
              }),
        ],
      ),
    );
  }

  static Future<dynamic> androidWriteCheckAlert(
      BuildContext context, TimerController timerController) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(k_AlertTitle),
        content: Text(k_AlertContent1 +
            Get.find<TimerController>().getCurrentTime() +
            k_AlertContent2),
        actions: <Widget>[
          TextButton(
            child: const Text(k_AlertYes),
            onPressed: () => Get.offAll(const MainPeedScreen()),
          ),
          TextButton(
            child: const Text(k_AlertNo),
            onPressed: () => Get.back(),
          ),
          TextButton(
              child: const Text(k_AlertCancle),
              onPressed: () {
                timerController.resetTimer();
                Get.offAll(const MainPeedScreen());
              }),
        ],
      ),
    );
  }
}
