import 'dart:io';

import 'package:fifteen_minute_diary/controller/card_scroll_controller.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/staggered_image_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/wide_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class BackCard extends StatelessWidget {
  const BackCard({
    Key? key,
    required this.title,
    required this.content,
    required this.imagelist,
    required this.writeDate,
    required this.duration,
    required this.dateTime,
  }) : super(key: key);

  final String title;
  final String content;
  final List<File>? imagelist;
  final DateTime? writeDate;
  final int duration;
  final DateTime? dateTime;

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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title.toString(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            GestureDetector(
                                onTap: () {
                                  showDeleteDiaryCupertinoActionSheet(context);
                                },
                                child: const Icon(Icons.more_vert_rounded))
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: GestureDetector(
                            onTap: () {
                              if (imagelist != null) {
                                Get.to(
                                    WideImageWidget(
                                      imagelist: imagelist,
                                    ),
                                    transition: Transition.downToUp,
                                    popGesture: false);
                              }
                            },
                            child: StaggeredImageView(imagelist: imagelist)),
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
                      )
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ));
  }

  void showDeleteDiaryCupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(
                  child: const Text(
                    '일기 삭제',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {
                    bool isSame = Get.find<PostController>()
                        .checkDateIsSame(dateTime!, DateTime.now());
                    if (!isSame) {
                      Get.find<PostController>()
                          .deletePostByWriteDate(dateTime);
                    } else {
                      showCantDeleteToast();
                    }
                    Get.back();
                  },
                ),
              ],
            ));
  }

  void showCantDeleteToast() {
    Fluttertoast.showToast(
        msg: "오늘 일기는 삭제할 수 없습니다.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade800,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
