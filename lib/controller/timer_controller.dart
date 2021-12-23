import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  RxString time = "15:00".obs;
  RxString subtext = "Click me. and write diary".obs;

  void startTimer() {
    time = "14:49".obs;
    subtext = "다 쓰거나 취소시 Click!!.".obs;
  }

  void resetTimer() {
    time = "15:00".obs;
    subtext = "Click me. and write diary".obs;
  }
}
