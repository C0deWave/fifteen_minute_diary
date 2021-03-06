import 'dart:math';

import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/custom_class/dialog_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;

class RecommendDiaryTopic {
  int topicIndex =
      Random(DateTime.now().microsecond.toInt()).nextInt(k_topiclist.length);

  void showDailyTopic(BuildContext context, {required Function() okFunction}) {
    foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS
        ? DialogList.showIosDailyTopic(context, topicIndex,
            okFunction: okFunction)
        : DialogList.showAndroidDailyTopic(context, topicIndex,
            okFunction: okFunction);
  }
}
