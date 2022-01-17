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
              var length = _controller.getPostlist().length - 1;
              return Container(
                color: Colors.white,
                child: CarouselSlider.builder(
                  itemBuilder: (BuildContext context, int index, int a) {
                    return DiaryCardViewWidget(
                        title: _controller.getPostlist()[length - index].title,
                        content:
                            _controller.getPostlist()[length - index].content,
                        imageList:
                            _controller.getPostlist()[length - index].imagelist,
                        writeDate:
                            _controller.getPostlist()[length - index].writeDate,
                        duration:
                            _controller.getPostlist()[length - index].duration);
                  },
                  itemCount: length + 1,
                  options: CarouselOptions(
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    height: Get.height * 0.83,
                    viewportFraction: 0.90,
                  ),
                ),
              );
            }),
        childCount: 1,
      ),
    );
  }
}
