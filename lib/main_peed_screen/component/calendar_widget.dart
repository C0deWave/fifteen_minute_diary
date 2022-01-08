import 'package:flutter/material.dart';
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
                        TableCalendar(
                          headerStyle: const HeaderStyle(
                            headerMargin: EdgeInsets.only(
                                left: 40, top: 10, right: 40, bottom: 10),
                            titleCentered: true,
                            formatButtonVisible: false,
                            leftChevronIcon: Icon(Icons.arrow_left),
                            rightChevronIcon: Icon(Icons.arrow_right),
                            titleTextStyle: TextStyle(fontSize: 17.0),
                          ),
                          calendarStyle: CalendarStyle(
                            outsideDaysVisible: true,
                            weekendTextStyle:
                                TextStyle().copyWith(color: Colors.red),
                            holidayTextStyle:
                                TextStyle().copyWith(color: Colors.blue[800]),
                          ),
                          locale: 'ko_KR',
                          firstDay: DateTime.utc(2019, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: DateTime.now(),
                        ),
                      ],
                    ),
                  ),
                ),
            childCount: 1));
  }
}
