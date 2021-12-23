import 'dart:io';

import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/timer_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/main_peed_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

import '../controller/timer_controller.dart';

class WriteDiaryScreen extends StatelessWidget {
  const WriteDiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerController = Get.put(TimerController());
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                      tag: k_timer_herotag,
                      child: TimerWidget(callback: () async {
                        Get.dialog(!Platform.isIOS
                            ? await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(k_alert_title),
                                  content: Text(k_alert_content),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(k_alert_yes),
                                      onPressed: () =>
                                          Get.offAll(MainPeedScreen()),
                                    ),
                                    TextButton(
                                      child: Text(k_alert_no),
                                      onPressed: () => Get.back(),
                                    ),
                                    TextButton(
                                        child: Text(k_alert_cancle),
                                        onPressed: () {
                                          timerController.resetTimer();
                                          Get.offAll(MainPeedScreen());
                                        }),
                                  ],
                                ),
                              )

                            // todo : showDialog for ios
                            : await showCupertinoDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  title: Text(k_alert_title),
                                  content: Text(k_alert_content),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text(k_alert_yes),
                                      onPressed: () =>
                                          Get.offAll(MainPeedScreen()),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(k_alert_no),
                                      onPressed: () => Get.back(),
                                    ),
                                    CupertinoDialogAction(
                                        child: Text(k_alert_cancle),
                                        onPressed: () {
                                          timerController.resetTimer();
                                          Get.offAll(MainPeedScreen());
                                        }),
                                  ],
                                ),
                              ));
                      })),
                ),
                const Center(
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
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
