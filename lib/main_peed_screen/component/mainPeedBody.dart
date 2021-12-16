import 'package:fifteen_minute_diary/main_peed_screen/component/tabbar_widget.dart';
import 'package:flutter/material.dart';

import 'TimerWidget.dart';
import 'diary_list_widget.dart';

class MainPeedBody extends StatelessWidget {
  const MainPeedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          // child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "당신의 1%를 기록하세요.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TimerWidget(
                callback: () {
                  print("click timer");
                },
              ),
            ),
          ],
          // ),
        ),
        TabbarWidget(),
        DiaryListWidget()
      ],
    );
  }
}
