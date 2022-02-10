import 'package:fifteen_minute_diary/controller/statistic_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/calandar_tab/calendar_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/calandar_tab/statistic_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalenderTabWidget extends StatelessWidget {
  const CalenderTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(StaticController());
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (content, i) => Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        SizedBox(height: 10),
                        StatisticWidget(),
                        SizedBox(height: 12),
                        CalendarWidget(),
                      ],
                    ),
                  ),
                ),
            childCount: 1));
  }
}
