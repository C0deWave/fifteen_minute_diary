import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/timer_controller.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({Key? key, required this.callback}) : super(key: key);
  final Function callback;
  @override
  Widget build(BuildContext context) {
    final timerController = Get.put(TimerController());
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        height: 110,
        // height: Get.height / 7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Color.fromARGB(255, 39, 88, 59),
            border: Border.all(width: 6)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: todo
            //TODO 타이머 기능 추가하기
            // 메인 화면에서는 가만히 있다가
            // 일기 화면으로 넘어가면 카운트 시작
            children: [
              GetBuilder<TimerController>(builder: (_) {
                return Text(
                  "${timerController.getTimeText()}",
                  style: const TextStyle(
                      fontSize: 62,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      fontFamily: 'Alarm_clock'),
                );
              }),
              Obx(() {
                return Text(
                  "${timerController.getSubText()}",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
