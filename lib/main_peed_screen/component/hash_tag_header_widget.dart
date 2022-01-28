import 'package:fifteen_minute_diary/controller/calendar_controller.dart';
import 'package:fifteen_minute_diary/controller/tag_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/hash_tag_tagging_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HashTagHeaderWidget extends StatelessWidget {
  const HashTagHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '검색',
            style: TextStyle(
                color: Color(0xff0f4a3c),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "지난 일기를 볼 수 있어요",
            style: TextStyle(
                color: Color.fromARGB(255, 48, 134, 114),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          GetBuilder<CalendarController>(builder: (calendarController) {
            return GetBuilder<TagController>(builder: (tagController) {
              tagController.setTaglist(calendarController.getSearchedTagList());
              var taglist = tagController.getTaglist();
              return SizedBox(
                height: 32,
                child: CustomScrollView(
                    scrollDirection: Axis.horizontal,
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (content, i) => HashTagTaggingItemWidget(
                                title: taglist[i].title,
                                isChecked: taglist[i].isChecked),
                            childCount: taglist.length),
                      ),
                    ]),
              );
            });
          }),
        ],
      ),
    );
  }
}
