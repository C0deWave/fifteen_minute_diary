import 'dart:io';

import 'package:fifteen_minute_diary/controller/card_scroll_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/staggered_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackCard extends StatelessWidget {
  const BackCard({
    Key? key,
    required this.title,
    required this.content,
    required this.imagelist,
    required this.writeDate,
    required this.duration,
  }) : super(key: key);

  final String title;
  final String content;
  final List<File>? imagelist;
  final DateTime? writeDate;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.black, width: 0.2)),
        elevation: 1,
        child: CustomScrollView(
          controller:
              Get.find<CardScrollController>().getChildScrollController(),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          title.toString(),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: StaggeredImageView(imagelist: imagelist),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          content,
                          // maxLines: 17,
                          // overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      Center(
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                '일기 삭제',
                                style: TextStyle(color: Colors.red),
                              )))
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ));
  }
}
