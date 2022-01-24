import 'dart:math';

import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendDiaryTopic {
  int topicIndex =
      Random(DateTime.now().microsecond.toInt()).nextInt(topiclist.length);
  void showDailyTopic(BuildContext context, {required Function okFunction}) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          '오늘의 일기 주제',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        content: Column(
          children: [
            Text(topiclist[topicIndex]),
            const Text('확인을 누르면 바로 일기를 쓰러 이동합니다.'),
          ],
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () async {
              Get.back();
            },
          ),
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: () async {
              Get.find<PostController>().updateTitleText(topiclist[topicIndex]);
              Get.back();
              okFunction();
            },
          )
        ],
      ),
    );
  }
}

List<String> topiclist = [
  '"오늘 먹은 음식은 어땠나요?"',
  '"최근에 가장 행복한 일이 뭐였나요?"',
];
