import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({Key? key, required this.callback}) : super(key: key);
  final Function callback;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Colors.grey.shade300),
        child: Center(
          child: Column(
            //TODO 타이머 기능 추가하기
            // 메인 화면에서는 가만히 있다가
            // 일기 화면으로 넘어가면 카운트 시작
            children: [
              Text(
                "15:00",
                style: TextStyle(
                    fontSize: 70,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none),
              ),
              Text(
                "Click me. and write diary",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
