import 'package:fifteen_minute_diary/controller/calendar_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/calandar_tab/hash_tag_card_item_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/calandar_tab/hash_tag_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

class HashTagWidget extends StatelessWidget {
  const HashTagWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, i) => Column(
                  children: [
                    SizedBox(height: 15),
                    Container(
                      width: 700,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [HashTagHeaderWidget()],
                      ),
                    ),
                    SizedBox(height: 15),
                    Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  alignment: Alignment.topCenter,
                                  image: Svg(
                                      'lib/assets/image/calendar_search/undraw_knowledge_re_leit.svg',
                                      size: Size(200, 500)))),
                          width: Get.width,
                          height: Get.height * 0.75,
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                            child: GetBuilder<CalendarController>(
                              builder: (calendarController) => Wrap(
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: calendarController
                                    .getFilteredPostList()
                                    .map((item) => HashTagCardItemWidget(
                                          width: Get.width * 0.472,
                                          postdata: item,
                                        ))
                                    .toList(),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
            childCount: 1));
  }
}
