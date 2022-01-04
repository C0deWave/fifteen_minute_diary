import 'package:carousel_slider/carousel_slider.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/diary_card_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryListWidget extends StatelessWidget {
  DiaryListWidget({
    Key? key,
    required this.postController,
  }) : super(key: key);

  final PostController postController;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => CarouselSlider(
          items: postController.postlist.reversed
              .map((item) => DiaryCardViewWidget(
                  title: item.title,
                  content: item.content,
                  image: item.image,
                  writeDate: item.writeDate,
                  duration: item.duration))
              .toList(),
          options: CarouselOptions(
            enableInfiniteScroll: false,
            height: Get.height * 0.83,
            viewportFraction: 0.90,
          ),
        ),
        childCount: 1,
      ),
    );
  }
}
