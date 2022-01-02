import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/diary_card_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryListWidget extends StatelessWidget {
  const DiaryListWidget({
    Key? key,
    required this.postController,
  }) : super(key: key);

  final PostController postController;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) => DiaryCardViewWidget(
          title: postController.postlist[i].title,
          content: postController.postlist[i].content,
          image: postController.postlist[i].image,
          writeDate: postController.postlist[i].writeDate,
          duration: postController.postlist[i].duration,
        ),
        //TODO : 일기 개수 반영하기
        childCount: postController.postlist.length,
      ),
    );
  }
}
