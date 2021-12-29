import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/controller/timer_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/tabbar_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/write_diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'diary_card_view_widget.dart';
import 'timer_widget.dart';

class MainPeedBody extends StatelessWidget {
  const MainPeedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: CustomScrollView(
          // shrinkWrap: true,
          slivers: [
            SliverStickyHeader(
              header: Container(),
              //타이머
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Hero(
                      tag: k_timer_herotag,
                      child: TimerWidget(
                        callback: () {
                          final timerController = Get.put(TimerController());
                          timerController.startTimer();
                          Get.to(() => WriteDiaryScreen());
                          print("click timer");
                        },
                      ),
                    ),
                  ),
                  childCount: 1,
                ),
              ),
            ),
            //일기 리스트
            SliverStickyHeader(
              header: TabbarWidget(),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => DiaryCardViewWidget(),
                  //TODO : 일기 개수 반영하기
                  childCount: 10,
                ),
              ),
            )
          ],
        ),
      )
    ]);
  }
}
