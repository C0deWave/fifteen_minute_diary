import 'package:fifteen_minute_diary/controller/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (content, i) => Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GetBuilder<CalendarController>(
                            // init: CalendarController(),
                            builder: (calenderController) {
                          return TableCalendar(
                              calendarBuilders:
                                  calenderController.getCalendarBuilder(),
                              onPageChanged: (focusedDay) =>
                                  calenderController.onDaySelected(focusedDay),
                              onDaySelected: (seletedDay, focusday) =>
                                  calenderController.onDaySelected(seletedDay),
                              headerStyle: calenderController.getHeaderStyle(),
                              calendarStyle:
                                  calenderController.getCalendarStyle(),
                              locale: 'ko_KR',
                              firstDay: DateTime.utc(2019, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              eventLoader: (data) =>
                                  calenderController.getEventLoader(data),
                              focusedDay: calenderController.getFocusDay(),
                              holidayPredicate: (date) =>
                                  calenderController.isHoliday(date),
                              selectedDayPredicate: (DateTime date) {
                                return isSameDay(
                                    calenderController.getFocusDay(), date);
                              }
                              // focusedDay: DateTime.utc(2022, 1, 15),
                              );
                        }),
                      ],
                    ),
                  ),
                ),
            childCount: 1));
  }
}
