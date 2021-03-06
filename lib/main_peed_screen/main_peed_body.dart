import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/controller/calendar_controller.dart';
import 'package:fifteen_minute_diary/controller/card_scroll_controller.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/controller/tabbar_controller.dart';
import 'package:fifteen_minute_diary/controller/timer_controller.dart';
import 'package:fifteen_minute_diary/custom_class/toast_list.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/calandar_tab/calendar_tab_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/cardview_tab/diary_carosel_card_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/calandar_tab/hash_tag_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/main_peed_app_bar.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/tabbar_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/write_diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'component/timer_widget.dart';

class MainPeedBody extends StatelessWidget {
  final String _tag = 'MainPeedBody: ';
  const MainPeedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postController = Get.put(PostController(), permanent: true);
    var tabbarController = Get.put(TabbarController());
    final timerController = Get.put(TimerController());
    final scrollController = Get.put(CardScrollController());
    Get.put(CalendarController());
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomScrollView(
                  controller: scrollController.getParentScrollController(),
                  // shrinkWrap: true,
                  slivers: [
                    SliverStickyHeader(
                      header: Container(),
                      //?????????
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => Column(
                            children: [
                              const MainPeedAppBar(),
                              Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  child: Hero(
                                    tag: k_TimerHerotag,
                                    child: TimerWidget(
                                      //15?????? ?????? ??????
                                      callback: () {
                                        if (timerController.haveTime()) {
                                          timerController.startTimer(
                                              finishFunction: () async {
                                                bool isWritePost =
                                                    await postController
                                                        .addPostList(
                                                            writeDuration:
                                                                timerController
                                                                    .getDuration());
                                                Get.find<CalendarController>()
                                                    .updateCalenderPostlist();
                                                isWritePost
                                                    ? timerController
                                                        .stopTimer()
                                                    : timerController
                                                        .resetTimer();
                                                Get.back();
                                              },
                                              remain1MinuteFunction: ToastList
                                                  .show1MinuteRemainToast);
                                          Get.to(
                                              () => const WriteDiaryScreen());
                                          debugPrint(_tag + "click timer");
                                        } else {
                                          ToastList
                                              .showNotHaveRemainTimeToast();
                                          debugPrint(_tag + '?????? ????????? ????????????.');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          childCount: 1,
                        ),
                      ),
                    ),
                    //?????? ?????????
                    GetBuilder<PostController>(builder: (_) {
                      return SliverStickyHeader(
                        header: Container(
                          color: Colors.white,
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(15, 6, 15, 0),
                            child: TabbarWidget(),
                          ),
                        ),
                        sliver: GetBuilder<TabbarController>(
                          init: TabbarController(),
                          builder: (_) {
                            if (tabbarController.currentState ==
                                TabbarState.diaryState) {
                              return const DiaryCaroselCardWidget();
                            } else {
                              return const CalenderTabWidget();
                            }
                          },
                        ),
                      );
                    }),
                    GetBuilder<TabbarController>(
                        init: TabbarController(),
                        builder: (_) {
                          if (tabbarController.currentState !=
                              TabbarState.diaryState) {
                            return const HashTagWidget();
                          } else {
                            return SliverStickyHeader();
                          }
                        }),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
