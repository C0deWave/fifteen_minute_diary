import 'package:fifteen_minute_diary/controller/calendar_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/hash_tag_card_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HashTagWidget extends StatelessWidget {
  const HashTagWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, i) => Stack(
                  children: [
                    Container(
                      width: Get.width,
                      height: Get.height * 0.76,
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
                        child: GetBuilder<CalendarController>(
                          builder: (calendarController) => Center(
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: calendarController
                                  .getFilteredPostList()
                                  .map((item) => HashTagCardItemWidget(
                                        width: Get.width * 0.47,
                                        postdata: item,
                                      ))
                                  .toList(),
                            ),
                          ),
                        )),
                  ],
                ),
            childCount: 1));
  }
}