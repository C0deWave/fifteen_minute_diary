import 'dart:async';
import 'package:fifteen_minute_diary/constant.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  TimerController() {
    time =
        "${twoDigits(_timerDuration ~/ 60)}:${twoDigits((_timerDuration % 60).toInt())}"
            .obs;
  }
  RxString time = "--:--".obs;
  int _timerDuration = k_TimerDuration;
  RxString subtext = "15분간 일기에 집중하세요".obs;
  // RxString subtext = "Click me. and write diary".obs;

  late DateTime writeDate;
  late Timer _timer;

  DateTime getWriteDate() => writeDate;
  int getDuration() {
    return k_TimerDuration - _timerDuration;
  }

  void startTimer({required Function callback}) {
    subtext = "다 쓰거나 취소시 Click!!.".obs;
    const oneSec = Duration(seconds: 1);
    writeDate = DateTime.now();
    print("타이머 시작");
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (_timerDuration <= 0) {
          timer.cancel();
          callback();
        } else {
          updateTimer();
        }
      },
    );
  }

  void resetTimer() {
    print('타이머 초기화');
    _timer.cancel();
    _timerDuration = k_TimerDuration;
    time =
        "${twoDigits(k_TimerDuration ~/ 60)}:${twoDigits((k_TimerDuration % 60).toInt())}"
            .obs;
    subtext = "Click me. and write diary".obs;
  }

  void updateTimer() async {
    _timerDuration -= 1;
    // print("${_timer_duration}");
    time =
        "${twoDigits(_timerDuration ~/ 60)}:${twoDigits((_timerDuration % 60).toInt())}"
            .obs;
    update();
  }

  String twoDigits(int n) => n >= 10 ? "$n" : "0$n";

  String getCurrentTime() {
    return "${twoDigits(_timerDuration ~/ 60)}:${twoDigits((_timerDuration % 60).toInt())}";
  }
}
