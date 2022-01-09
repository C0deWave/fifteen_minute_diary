import 'dart:async';
import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/custom_class/hive_database.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  //----------------------------------------------------------------------
  // 변수
  // 로그 확인용 태그
  final String _tag = 'timer_controller: ';
  // 현재시간 확인용 String
  RxString _time = "--:--".obs;
  // 현재 남은시간
  int _timerDuration = k_TimerTotalDuration;
  // 타이머 밑 subtext
  RxString _subtext = "15분간 일기에 집중해 주세요!".obs;
  // Hive데이터 베이스
  late HiveDataBase _postBox;
  DateTime _writeDate = DateTime.now();
  late Timer _timer;

  //----------------------------------------------------------------------
  // 함수
  // 초기화 함수
  @override
  void onInit() {
    _postBox = HiveDataBase();
    var temp = _postBox.getPost(_getTodayDiaryKey());
    if (temp != null) {
      debugPrint(_tag + "글이 생성되어 있습니다.");
      _timerDuration = k_TimerTotalDuration - temp.duration;
    } else {
      _timerDuration = k_TimerTotalDuration;
    }
    _updateSubtext();
    _time = _getTimeString();
    update();
    super.onInit();
  }

  // 현재 시간을 반환환다.
  DateTime getWriteDate() => _writeDate;
  RxString getTimeText() => _time;
  RxString getSubText() => _subtext;

  // 글쓰는데 사용한 시간을 초단위로 반환환다.
  int getDuration() {
    return k_TimerTotalDuration - _timerDuration;
  }

  // 현재 시간값을 업데이트 하는데 사용한다.
  RxString _getTimeString() {
    return "${_twoDigits(_timerDuration ~/ 60)}:${_twoDigits((_timerDuration % 60).toInt())}"
        .obs;
  }

  // 오늘날짜의 키를 반환한다.
  String _getTodayDiaryKey() {
    _writeDate = DateTime.now();
    return _writeDate.year.toString() +
        _twoDigits(_writeDate.month) +
        _twoDigits(_writeDate.day);
  }

  // 타이머를 시작한다. callback으로 0초가 되었을때 함수를 실행한다.
  void startTimer({required Function finishFunction}) {
    _subtext = "다 쓰거나 취소시 Click!!.".obs;
    debugPrint(_tag + "타이머 시작");
    _timer = Timer.periodic(
      k_OneSec,
      (Timer timer) async {
        if (_timerDuration <= 0) {
          timer.cancel();
          finishFunction();
        } else {
          _updateTimer();
        }
      },
    );
  }

  // 타이머를 종료합니다.
  void stopTimer() {
    debugPrint(_tag + '타이머 초기화');
    _timer.cancel();
    _time = _getTimeString();
    _updateSubtext();
  }

  // 시간 값을 1초씩 빼고 time텍스트를 업데이트한다.
  void _updateTimer() {
    _timerDuration -= 1;
    _time = _getTimeString();
    update();
  }

  // 숫자 포맷을 두자리로 한다.
  String _twoDigits(int n) => n >= 10 ? "$n" : "0$n";

  //남은 시간이 있는지 확인합니다.
  bool haveTime() {
    return _timerDuration > 0;
  }

  // subtext를 조건에 맞게 업데이트 합니다.
  void _updateSubtext() {
    if (_timerDuration == k_TimerTotalDuration) {
      _subtext = "15분간 일기에 집중해 주세요!".obs;
    } else if (_timerDuration == 0) {
      _subtext = "시간을 다 써서 더이상 수정할 수 없습니다.".obs;
    } else {
      _subtext = "남은 시간동안 수정할 수 있습니다.".obs;
    }
  }
}
