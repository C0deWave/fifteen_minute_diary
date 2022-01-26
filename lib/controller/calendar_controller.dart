import 'package:fifteen_minute_diary/custom_class/hive_database.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  //----------------------------------------------------------------------------
  // 변수
  final String _tag = 'calendarController: ';
  List<Post> _postlist = [];
  // List<DateTime> _dateTime = [];
  DateTime _focusDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  int _totalDay = 0;
  int _dailyDay = 0;
  int _totalTime = 0;
  int _dailyTime = 0;
  List<double> _weeklyData = [0, 0, 0, 0, 0, 15, 15];

  //----------------------------------------------------------------------------
  // 함수
  // init 초기화 함수
  @override
  void onInit() {
    debugPrint("Calendar Controller 주입");
    _focusDay = DateTime.now();
    _postlist = _getPostlistFromPostbox();
    // _dateTime = _getDatelistFromPostlist();
    updateWeeklyData(_focusDay);
    updateTotalDaysAndTime(year: _focusDay.year, month: _focusDay.month);
    updateDailyDaysAndTime(year: _focusDay.year, month: _focusDay.month);
    super.onInit();
  }

  // 현재 선택한 날짜 반환
  DateTime getFocusDay() => _focusDay;
  CalendarFormat getCalendarFormat() => _calendarFormat;
  getTotalDay() => _totalDay;
  getDailyDay() => _dailyDay;
  getTotalTime() => _totalTime;
  getDailyTime() => _dailyTime;
  List<double> getWeeklyData() => _weeklyData;

  // 저장소에서 일기 데이터를 긁어 옵니다.
  List<Post> _getPostlistFromPostbox() {
    var _postBox = HiveDataBase();
    List<Post> templist = [];
    debugPrint(_tag + "저장소에서 글을 불러옵니다.");
    for (var i = 0; i < _postBox.getLength(); i++) {
      var tempPost = _postBox.getAtPost(i);
      if (tempPost != null) {
        templist.add(tempPost);
      }
    }
    debugPrint("postBox: ${_postBox.getLength()}");
    return templist;
  }

  // 캘린더로 탭 전환을 할때 게시글 목록을 업데이트 해줍니다.
  void updateCalenderPostlist() {
    _postlist = _getPostlistFromPostbox();
    update();
  }

  // Holiday인지 확인합니다.
  isHoliday(DateTime date) {
    for (var i = 0; i < _postlist.length; i++) {
      if (_checkSameDay(_postlist[i].writeDate!, date)) {
        return true;
      }
    }
    return false;
  }

  // 같은 날짜인지 확인합니다.
  bool _checkSameDay(DateTime date1, DateTime date2) {
    return (date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day);
  }

  //weekly데이터를 업데이트 합니다.
  updateWeeklyData(DateTime date) {
    //월 , 화 , 수 , 목 , 금 , 토 , 일
    // 1   2   3   4    5   6   7
    int currentDay = date.weekday;
    var standardDay = date.subtract(Duration(days: currentDay)).toUtc();
    print('탐색을 시작합니다. 기준일 : ${standardDay}');
    List<double> tempWeeklyData = [];
    // 일요일 부터 차례대로 1주 탐색
    for (var i = 0; i < 7; i++) {
      var temp = _getPostofDate(standardDay);
      if (temp != null) {
        tempWeeklyData.add(temp.duration / 60);
      } else {
        tempWeeklyData.add(0);
      }
      standardDay = standardDay.subtract(const Duration(days: -1));
      print(standardDay);
    }
    _weeklyData = tempWeeklyData;
    print(_weeklyData);
    update();
  }

  // 작성글 리스트에서 해당 일자가 있는지 확인한다.
  Post? _getPostofDate(DateTime date) {
    for (var i = 0; i < _postlist.length; i++) {
      DateTime temp = _postlist[i].writeDate!;
      if (temp.year == date.year &&
          temp.month == date.month &&
          temp.day == date.day) {
        debugPrint('글을 찾았습니다.');
        return _postlist[i];
      }
    }
    return null;
  }

  // 캘린더 포맷을 변경합니다.
  calendarFormatChange() {
    if (_calendarFormat == CalendarFormat.month) {
      _calendarFormat = CalendarFormat.week;
      updateWeeklyData(_focusDay);
    } else {
      _calendarFormat = CalendarFormat.month;

      updateTotalDaysAndTime(year: _focusDay.year, month: _focusDay.month);
      updateDailyDaysAndTime(year: _focusDay.year, month: _focusDay.month);
    }
    update();
  }

  //페이지가 스와이프 되었을때
  onPageSelected(DateTime focusedDay) {
    debugPrint('페이지 변환 ${focusedDay.toString()}');
    _focusDay = focusedDay;
    updateWeeklyData(_focusDay);
    updateTotalDaysAndTime(year: _focusDay.year, month: _focusDay.month);
    updateDailyDaysAndTime(year: _focusDay.year, month: _focusDay.month);
  }

  // focusDay를 선택한 일자로 업데이트 합니다.
  onDaySelected(DateTime seletedDay) {
    debugPrint('일자 선택 ${seletedDay.toString()}');
    _focusDay = seletedDay;
    updateWeeklyData(_focusDay);
    updateTotalDaysAndTime(year: _focusDay.year, month: _focusDay.month);
    updateDailyDaysAndTime(year: _focusDay.year, month: _focusDay.month);
    update();
  }

  void updateDailyDaysAndTime({required int year, required int month}) {
    if (_calendarFormat == CalendarFormat.month) {
      _dailyDay = 0;
      _dailyTime = 0;
      for (var i = 1; i < _totalDay + 1; i++) {
        for (var j = 0; j < _postlist.length; j++) {
          if (_checkSameDay(
              _postlist[j].writeDate!, DateTime.utc(year, month, i))) {
            debugPrint('데일리 찾음');
            _dailyDay++;
            _dailyTime += _postlist[j].duration ~/ 60;
          }
        }
      }
    }
  }

  // 년월을 받아서 전체 일자를 반환해 줍니다.
  void updateTotalDaysAndTime({required int year, required int month}) {
    int days = 0;
    switch (month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        days = 31;
        break;
      case 4:
      case 6:
      case 9:
      case 11:
        days = 30;
        break;
      case 2:
        days = year % 4 == 0 ? 29 : 28;
        break;
      default:
        break;
    }
    _totalDay = days;
    _totalTime = days * 15;
    update();
  }

  //스타일 -----------------------------------------------------------------
  // 헤더 스타일을 반환
  HeaderStyle getHeaderStyle() => const HeaderStyle(
        headerMargin: EdgeInsets.only(left: 40, top: 0, right: 40, bottom: 5),
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronIcon: Icon(Icons.arrow_left),
        rightChevronIcon: Icon(Icons.arrow_right),
        titleTextStyle: TextStyle(fontSize: 17.0),
      );

  // 월화수목금토일 부분 디자인 코드
  Widget _getdoWBuilder(BuildContext context, DateTime day) {
    final text = DateFormat.E('ko_KR').format(day);
    return Center(
        child: Text(text,
            style: (day.weekday == DateTime.sunday ||
                    day.weekday == DateTime.saturday)
                ? const TextStyle(color: Colors.red)
                : const TextStyle(color: Colors.black)));
  }

  // 저번달 다음달 날짜들 표시 안함
  Widget _getOutsideBuilder(
      BuildContext context, DateTime date, DateTime olderDate) {
    return _getDefaultCalendarItem(date,
        textColor:
            _calendarFormat == CalendarFormat.month ? Colors.grey : null);
  }

  // 선택한 날짜 디자인
  Widget _getSelectedBuilder(
      BuildContext context, DateTime date, DateTime olderDate) {
    DateTime nowDate = DateTime.now();
    return _getDefaultCalendarItem(date,
        boxDecoration: _getDefaultBoxDecoration(date).copyWith(
            // border: Border.all(
            //     width: 3,
            //     color: _getHolidayColors(
            //         DateTime.utc(nowDate.year, nowDate.month, nowDate.day)))
            ));
  }

  // 가본 일자 디자인
  Widget _getDefaultCalendarItem(DateTime date,
      {BoxDecoration? boxDecoration, MaterialColor? textColor}) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Container(
        decoration: boxDecoration ?? _getDefaultBoxDecoration(date),
        child: Center(
            child: Text(date.day.toString(),
                style: (date.weekday == DateTime.sunday ||
                        date.weekday == DateTime.saturday)
                    ? TextStyle(color: textColor ?? Colors.red)
                    : TextStyle(color: textColor ?? Colors.black))),
      ),
    );
  }

  //특별한 날 표시
  Widget _getHolidayBuilder(
      BuildContext context, DateTime date, DateTime olderDate) {
    return _getDefaultCalendarItem(date);
  }

  // 일반적인 요일들 주말 : 빨강
  Widget _getDefaultBuilder(
      BuildContext context, DateTime date, DateTime olderDate) {
    return _getDefaultCalendarItem(date);
  }

  // CalendatBuilder를 반환
  CalendarBuilders getCalendarBuilder() => CalendarBuilders(
      dowBuilder: _getdoWBuilder,
      selectedBuilder: _getSelectedBuilder,
      holidayBuilder: _getHolidayBuilder,
      defaultBuilder: _getDefaultBuilder,
      outsideBuilder: _getOutsideBuilder);

  // 캘린더 스타일을 받습니다. 오늘날짜 표시 제거
  getCalendarStyle() => const CalendarStyle(isTodayHighlighted: false);

  // 작성 시간동안 색상을 반환해 줍니다.
  Color _getHolidayColors(DateTime date) {
    Post? post = _getPostofDate(date);
    if (post != null) {
      int duration = ((post.duration / (60 * 15)) * 255).toInt() + 80;
      if (duration > 255) {
        duration = 255;
      }
      return Color.fromARGB(duration, 49, 139, 49);
    }
    return Colors.white;
  }

  // 기본 BoxDecoration
  BoxDecoration _getDefaultBoxDecoration(date) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: _getHolidayColors(date),
    );
  }
}
