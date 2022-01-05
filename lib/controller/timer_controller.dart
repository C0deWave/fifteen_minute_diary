import 'dart:async';
import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/custom_class/hive_database.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  static final TimerController _controller = TimerController._internal();
  TimerController._internal() {
    postBox = HiveDataBase();
    writeDate = DateTime.now();
    var temp = postBox.getPost(writeDate.year.toString() +
        addZero(writeDate.month) +
        addZero(writeDate.day));
    if (temp != null) {
      if (k_DebugMode) {
        // ignore: avoid_print
        print("글이 생성되어 있습니다.");
      }
      _timerDuration = k_TimerDuration - temp.duration;
    } else {
      _timerDuration = k_TimerDuration;
    }
    updateSubtext(_timerDuration);
    time =
        "${twoDigits(_timerDuration ~/ 60)}:${twoDigits((_timerDuration % 60).toInt())}"
            .obs;
    update();
  }
  factory TimerController() {
    return _controller;
  }

  @override
  onInit() {
    print("컨트롤러 생성");
  }

  RxString time = "--:--".obs;
  late int _timerDuration = k_TimerDuration;
  // int _timerDuration = k_TimerDuration;
  RxString subtext = "15분간 일기에 집중하세요".obs;
  // RxString subtext = "Click me. and write diary".obs;

  late HiveDataBase postBox;
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
    if (k_DebugMode) {
      // ignore: avoid_print
      print("타이머 시작");
    }
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
    if (k_DebugMode) {
      // ignore: avoid_print
      print('타이머 초기화');
    }
    _timer.cancel();
    // _timerDuration = k_TimerDuration;
    time =
        "${twoDigits(_timerDuration ~/ 60)}:${twoDigits((_timerDuration % 60).toInt())}"
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

  bool haveTime() {
    if (_timerDuration > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onClose() {
    postBox.closeDatabase();
    super.onClose();
  }

  String addZero(int num) {
    if (num < 10) {
      return "0$num";
    }
    return "$num";
  }

  void updateSubtext(int timerDuration) {
    if (timerDuration == k_TimerDuration) {
      subtext = "15분간 일기에 집중해 주세요!".obs;
    } else if (timerDuration == 0) {
      subtext = "시간을 다 써서 더이상 수정할 수 없습니다.".obs;
    } else {
      subtext = "남은 시간동안 수정할 수 있습니다.".obs;
    }
  }
}
