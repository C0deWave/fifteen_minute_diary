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
        height: 100,
        // height: Get.height / 7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Colors.grey.shade300),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //TODO 타이머 기능 추가하기
            // 메인 화면에서는 가만히 있다가
            // 일기 화면으로 넘어가면 카운트 시작
            children: [
              GetBuilder<TimerController>(builder: (_) {
                return Text(
                  "${timerController.time}",
                  style: const TextStyle(
                      fontSize: 60,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none),
                );
              }),
              Obx(() {
                return Text(
                  "${timerController.subtext}",
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
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
