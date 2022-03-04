import 'package:carousel_slider/carousel_slider.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/cardview_tab/diary_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryCaroselCardWidget extends StatelessWidget {
  const DiaryCaroselCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => GetBuilder<PostController>(
            init: PostController(),
            builder: (_controller) {
              var length = _controller.getPostlist().length;
              var postlist = _controller.getPostlist().reversed.toList();
              final availableHeight = MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom;
              return Container(
                height: availableHeight - 5,
                color: Colors.white,
                child: CarouselSlider.builder(
                  itemBuilder: (BuildContext context, int index, int a) {
                    return DiaryCardItem(
                      title: postlist[index].title,
                      content: postlist[index].content,
                      imageList: postlist[index].imagelist,
                      writeDate: postlist[index].writeDate,
                      duration: postlist[index].duration,
                      dateTime: postlist[index].writeDate,
                      hashtags: postlist[index].hashtags,
                    );
                  },
                  itemCount: length,
                  options: CarouselOptions(
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    height: availableHeight - 15,
                    viewportFraction: 0.9,
                  ),
                  carouselController: _controller.getCarouselConteoller(),
                ),
              );
            }),
        childCount: 1,
      ),
    );
  }
}
