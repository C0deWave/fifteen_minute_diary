import 'package:carousel_slider/carousel_slider.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/diary_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryCaroselCardWidget extends StatelessWidget {
  DiaryCaroselCardWidget({
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
                    var _temp = _controller.getPostlist()[length - index];
                    return DiaryCardItem(
                      title: _temp.title,
                      content: _temp.content,
                      imageList: _temp.imagelist,
                      writeDate: _temp.writeDate,
                      duration: _temp.duration,
                      dateTime: _temp.writeDate,
                      hashtags: _temp.hashtags,
                    );
                  },
                  itemCount: length + 1,
                  options: CarouselOptions(
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    height: Get.height * 0.89,
                    viewportFraction: 0.9,
                  ),
                ),
              );
            }),
        childCount: 1,
      ),
    );
  }
}
