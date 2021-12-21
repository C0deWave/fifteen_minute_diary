import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/TimerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

class WriteDiaryScreen extends StatelessWidget {
  const WriteDiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 4),
            Hero(
                tag: k_timer_herotag,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TimerWidget(callback: () {}),
                )),
            SizedBox(
              height: 8,
            ),
            Center(
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                maxLines: 1,
                minLines: 1,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  hintText: "제목을 적어주세요.",
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 7, //Normal textInputField will be displayed
                  maxLines: 7,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: "15분간 일기를 써 주세요.",
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
