import 'package:carousel_slider/carousel_slider.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/diary_card_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryListWidget extends StatelessWidget {
  DiaryListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => GetBuilder<PostController>(
            init: PostController(),
            builder: (_controller) {
              return CarouselSlider.builder(
                itemBuilder: (BuildContext context, int index, int a) =>
                    DiaryCardViewWidget(
                        title: _controller.getPostlist()[index].title,
                        content: _controller.getPostlist()[index].content,
                        image: _controller.getPostlist()[index].image,
                        writeDate: _controller.getPostlist()[index].writeDate,
                        duration: _controller.getPostlist()[index].duration),
                itemCount: _controller.getPostlist().length,
                options: CarouselOptions(
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  height: Get.height * 0.83,
                  viewportFraction: 0.90,
                ),
              );
            }),
        childCount: 1,
      ),
    );
  }
}
