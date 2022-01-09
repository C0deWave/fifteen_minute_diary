import 'package:fifteen_minute_diary/constant.dart';
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
  List<DateTime> _dateTime = [];
  DateTime _focusDay = DateTime.now();

  //----------------------------------------------------------------------------
  // 함수
  // init 초기화 함수
  @override
  void onInit() {
    debugPrint("Calendar Controller 주입");
    _focusDay = DateTime.now();
    _postlist = _getPostlistFromPostbox();
    _dateTime = _getDatelistFromPostlist();
    super.onInit();
  }

  // 현재 선택한 날짜 반환
  DateTime getFocusDay() => _focusDay;

  // 헤더 스타일을 반환
  HeaderStyle getHeaderStyle() => const HeaderStyle(
        headerMargin: EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 10),
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronIcon: Icon(Icons.arrow_left),
        rightChevronIcon: Icon(Icons.arrow_right),
        titleTextStyle: TextStyle(fontSize: 17.0),
      );

  // CalendatBuilder를 반환
  CalendarBuilders getCalendarBuilder() => CalendarBuilders(
      dowBuilder: _getdoWBuilder,
      todayBuilder: _getTodayBuilder,
      selectedBuilder: _getSelectedBuilder,
      // disabledBuilder: _getDisableBuilder
      holidayBuilder: _getHolidayBuilder,
      defaultBuilder: _getDefaultBuilder,
      outsideBuilder: _getOutsideBuilder);

  //특별한 날 표시
  Widget _getHolidayBuilder(
      BuildContext context, DateTime date, DateTime olderDate) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _getHolidayColors(date),
          // color: Colors.green.shade100,
        ),
        child: Center(
            child: Text(date.day.toString(),
                style: (date.weekday == DateTime.sunday ||
                        date.weekday == DateTime.saturday)
                    ? const TextStyle(color: Colors.red)
                    : const TextStyle(color: Colors.black))),
      ),
    );
  }

  // 일반적인 요일들 주말 : 빨강
  Widget _getDefaultBuilder(
      BuildContext context, DateTime date, DateTime olderDate) {
    return Center(
        child: Text(date.day.toString(),
            style: (date.weekday == DateTime.sunday ||
                    date.weekday == DateTime.saturday)
                ? const TextStyle(color: Colors.red)
                : const TextStyle(color: Colors.black)));
  }

  // 저번달 다음달 날짜들
  Widget _getOutsideBuilder(
      BuildContext context, DateTime date, DateTime olderDate) {
    return Container();
  }

  // 뭔지 모름
  Widget _getDisableBuilder(
      BuildContext context, DateTime date, DateTime olderDate) {
    return Container();
  }

  //오늘 날짜 디자인
  Widget _getTodayBuilder(
      BuildContext context, DateTime date, DateTime olderDate) {
    final text = DateFormat.E('ko_KR').format(date);
    return Center(
        child: Text(text,
            style: (date.weekday == DateTime.sunday ||
                    date.weekday == DateTime.saturday)
                ? const TextStyle(color: Colors.red)
                : const TextStyle(color: Colors.black)));
  }

  // 선택한 날짜 디자인
  Widget _getSelectedBuilder(
      BuildContext context, DateTime date, DateTime olderDate) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.green)),
      child: Center(
          child: Text(date.day.toString(),
              style: (date.weekday == DateTime.sunday ||
                      date.weekday == DateTime.saturday)
                  ? const TextStyle(color: Colors.red)
                  : const TextStyle(color: Colors.black))),
    );
  }

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

  // 일기데이터에서 날짜만 긁어서 시,분을 제거해 저장합니다.
  List<DateTime> _getDatelistFromPostlist() {
    List<DateTime> temp = [];
    for (var i = 0; i < _postlist.length; i++) {
      var sDate = DateTime.utc(_postlist[i].writeDate!.year,
          _postlist[i].writeDate!.month, _postlist[i].writeDate!.day);
      debugPrint(sDate.toString());
      temp.add(sDate);
    }
    return temp;
  }

  // 캘린더로 탭 전환을 할때 게시글 목록을 업데이트 해줍니다.
  void updateCalenderPostlist() {
    _postlist = _getPostlistFromPostbox();
    update();
  }

  // 선택한 일자를 업데이트 합니다.
  onDaySelected(DateTime seletedDay) {
    _focusDay = seletedDay;
    debugPrint(_tag + "onDaySelected" + _focusDay.toString());
    update();
  }

  // 해당 날짜에 이벤트가 있는지 확인합니다.
  getEventLoader(var date) {
    List<dynamic> temp = [];
    // if (_dateTime.contains(date as DateTime)) {
    //   temp.add(Text("data"));
    // }
    return temp;
  }

  // Holiday인지 확인합니다.
  isHoliday(DateTime date) {
    if (_dateTime.contains(date as DateTime)) {
      return true;
    } else {
      return false;
    }
  }

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

  Post? _getPostofDate(DateTime date) {
    for (var i = 0; i < _postlist.length; i++) {
      DateTime temp = _postlist[i].writeDate!;
      if (temp.year == date.year &&
          temp.month == date.month &&
          temp.day == date.day) {
        debugPrint('글을 찾았습니다.' + date.month.toString() + date.day.toString());
        debugPrint(_postlist[i].duration.toString());
        return _postlist[i];
      }
    }
    return null;
  }
}
