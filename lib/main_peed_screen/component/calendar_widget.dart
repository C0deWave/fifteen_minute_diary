import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (content, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TableCalendar(
                    locale: 'ko_KR',
                    firstDay: DateTime.utc(2019, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                  ),
                ),
            childCount: 1));
  }
}
