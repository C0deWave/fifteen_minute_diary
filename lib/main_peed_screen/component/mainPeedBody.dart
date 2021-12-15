import 'package:flutter/material.dart';

import 'TimerWidget.dart';

class MainPeedBody extends StatelessWidget {
  const MainPeedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "당신의 1%를 기록하세요.",
            style: TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: TimerWidget(
            callback: () {
              print("click timer");
            },
          ),
        ),
      ],
    );
  }
}
