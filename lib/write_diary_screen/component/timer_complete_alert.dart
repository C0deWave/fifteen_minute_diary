import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/controller/timer_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerCompleteAlert {
  _yesAction() {
    TimerController timerController = Get.find<TimerController>();
    Get.find<PostController>().addPostList(
        timerController.getWriteDate(), timerController.getDuration());
    timerController.resetTimer();
    Get.back();
    Get.back();
  }

  _noAction() {
    Get.back();
  }

  _cancleAction() {
    TimerController timerController = Get.find<TimerController>();
    timerController.resetTimer();
    Get.find<PostController>().resetWriteState();
    Get.back();
    Get.back();
  }

  Future<dynamic> iosWriteCheckAlert(BuildContext context) {
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
            onPressed: _yesAction,
          ),
          CupertinoDialogAction(
            child: const Text(k_AlertNo),
            onPressed: _noAction,
          ),
          CupertinoDialogAction(
              child: const Text(k_AlertCancle), onPressed: _cancleAction),
        ],
      ),
    );
  }

  Future<dynamic> androidWriteCheckAlert(BuildContext context) {
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
            onPressed: _yesAction,
          ),
          TextButton(
            child: const Text(k_AlertNo),
            onPressed: _noAction,
          ),
          TextButton(
              child: const Text(k_AlertCancle), onPressed: _cancleAction),
        ],
      ),
    );
  }
}
