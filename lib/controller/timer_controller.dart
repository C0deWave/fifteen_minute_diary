import 'dart:async';
import 'package:get/get.dart';

class TimerController extends GetxController {
  RxString time = "15:00".obs;
  RxString subtext = "15분간 일기에 집중하세요".obs;
  // RxString subtext = "Click me. and write diary".obs;

  int _timer_duration = 60 * 15;
  late DateTime writeDate;
  late Timer _timer;

  DateTime getWriteDate() => writeDate;
  int getDuration() {
    return 60 * 15 - _timer_duration;
  }

  void startTimer() {
    subtext = "다 쓰거나 취소시 Click!!.".obs;
    const oneSec = Duration(seconds: 1);
    writeDate = DateTime.now();
    print("타이머 시작");
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (_timer_duration <= 0) {
          timer.cancel();
        } else {
          updateTimer();
        }
      },
    );
  }

  void resetTimer() {
    print('타이머 초기화');
    _timer.cancel();
    _timer_duration = 60 * 15;
    time = "15:00".obs;
    subtext = "Click me. and write diary".obs;
  }

  void updateTimer() async {
    _timer_duration -= 1;
    // print("${_timer_duration}");
    time =
        "${twoDigits((_timer_duration / 60).toInt())}:${twoDigits((_timer_duration % 60).toInt())}"
            .obs;
    update();
  }

  String twoDigits(int n) => n >= 10 ? "$n" : "0$n";
}
