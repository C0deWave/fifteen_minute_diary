import 'dart:math';

import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/custom_class/dialog_list.dart';
import 'package:flutter/cupertino.dart';

class RecommendDiaryTopic {
  int topicIndex =
      Random(DateTime.now().microsecond.toInt()).nextInt(k_topiclist.length);

  void showDailyTopic(BuildContext context, {required Function() okFunction}) {
    DialogList.showIosDailyTopic(context, topicIndex, okFunction: okFunction);
  }
}
