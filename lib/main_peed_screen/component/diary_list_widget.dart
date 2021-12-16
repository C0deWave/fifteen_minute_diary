import 'package:fifteen_minute_diary/main_peed_screen/component/DiaryCardViewWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryListWidget extends StatelessWidget {
  const DiaryListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(shrinkWrap: true, children: [
        DiaryCardViewWidget(),
        DiaryCardViewWidget(),
        DiaryCardViewWidget(),
      ]),
    );
  }
}
