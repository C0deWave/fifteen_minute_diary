import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/controller/tabbar_controller.dart';
import 'package:fifteen_minute_diary/controller/timer_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/calendar_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/diary_list_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/tabbar_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/write_diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'timer_widget.dart';

class MainPeedBody extends StatelessWidget {
  final String _tag = 'MainPeedBody: ';
  const MainPeedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postController = Get.put(PostController());
    var tabbarController = Get.put(TabbarController());
    final timerController = Get.put(TimerController());
    return Container(
      color: Colors.white,
      child: Column(children: [
        Expanded(
          child: CustomScrollView(
            // shrinkWrap: true,
            slivers: [
              SliverStickyHeader(
                header: Container(),
                //타이머
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Hero(
                          tag: k_TimerHerotag,
                          child: TimerWidget(
                            callback: () {
                              if (timerController.haveTime()) {
                                timerController.startTimer(finishFunction: () {
                                  postController.addPostList(
                                      writeDuration:
                                          timerController.getDuration());
                                  timerController.stopTimer();
                                  Get.back();
                                });
                                Get.to(() => const WriteDiaryScreen());
                                debugPrint(_tag + "click timer");
                              } else {
                                debugPrint(_tag + '남은 시간이 없습니다.');
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    childCount: 1,
                  ),
                ),
              ),
              //일기 리스트
              GetBuilder<PostController>(builder: (_) {
                return SliverStickyHeader(
                  header: TabbarWidget(),
                  sliver: GetBuilder<TabbarController>(
                    init: TabbarController(),
                    builder: (_) {
                      if (tabbarController.currentState ==
                          TabbarState.diaryState) {
                        return DiaryListWidget();
                      } else {
                        return const CalenderWidget();
                      }
                    },
                  ),
                );
              })
            ],
          ),
        )
      ]),
    );
  }
}
