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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 150,
          // height: Get.height / 7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              color: Color.fromARGB(255, 39, 88, 59),
              border: Border.all(width: 0)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                      child: Text(
                        "일기쓰기",
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() {
                        return Text(
                          "${timerController.getSubText()}",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none),
                        );
                      }),
                    ],
                  ),
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
