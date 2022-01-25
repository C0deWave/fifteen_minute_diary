import 'package:fifteen_minute_diary/controller/calendar_controller.dart';
import 'package:fifteen_minute_diary/controller/statistic_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarChangeFormatButtonWidget extends StatelessWidget {
  const CalendarChangeFormatButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(
      builder: (controller) => TextButton(
          onPressed: () {
            controller.calendarFormatChange();
            Get.find<StaticController>().setShowChartData(
                status: !Get.find<StaticController>().getShowChartData());
          },
          child: Text(controller.getCalendarFormat() == CalendarFormat.month
              ? "주차별로 보기"
              : "월별로 보기")),
    );
  }
}
