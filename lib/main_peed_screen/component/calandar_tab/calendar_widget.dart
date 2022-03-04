import 'package:fifteen_minute_diary/controller/calendar_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/calandar_tab/calendar_change_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(builder: (calenderController) {
      // calenderController.updateCalenderPostlist();
      return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(width: 3, color: Color.fromARGB(255, 36, 90, 59))),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    '캘린더',
                    style: TextStyle(
                        color: Color(0xff0f4a3c),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  TableCalendar(
                      pageJumpingEnabled: false,
                      availableGestures: AvailableGestures.horizontalSwipe,
                      calendarFormat: calenderController.getCalendarFormat(),
                      calendarBuilders: calenderController.getCalendarBuilder(),
                      onPageChanged: (focusedDay) =>
                          calenderController.onPageSelected(focusedDay),
                      onDaySelected: (seletedDay, focusday) =>
                          calenderController.onDaySelected(seletedDay),
                      headerStyle: calenderController.getHeaderStyle(),
                      calendarStyle: calenderController.getCalendarStyle(),
                      locale: 'ko_KR',
                      firstDay: DateTime.utc(2019, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: calenderController.getFocusDay(),
                      holidayPredicate: (date) =>
                          calenderController.isHoliday(date),
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(
                            calenderController.getFocusDay(), date);
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      CalendarChangeFormatButtonWidget(),
                      SizedBox(width: 20)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
