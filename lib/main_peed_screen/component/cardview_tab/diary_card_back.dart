import 'dart:io';

import 'package:fifteen_minute_diary/controller/card_scroll_controller.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/controller/wide_image_controller.dart';
import 'package:fifteen_minute_diary/custom_class/action_sheet_list.dart';
import 'package:fifteen_minute_diary/custom_class/dialog_list.dart';
import 'package:fifteen_minute_diary/custom_class/toast_list.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/cardview_tab/staggered_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';

class DiaryCardBack extends StatelessWidget {
  const DiaryCardBack({
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
    Get.put(WideImageController());
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: Colors.black, width: 0.2)),
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
                            Flexible(
                              child: Text(
                                title.toString(),
                                maxLines: 3,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            writeDate != null
                                ? GestureDetector(
                                    onTap: () =>
                                        ActionSheetList.showDeleteDiarySheet(
                                            context: context,
                                            deleteAction: () {
                                              DialogList
                                                  .showIosDeleteDiaryAlert(
                                                      context: context,
                                                      yesAction: () {
                                                        Get.back();
                                                        bool isSame = Get.find<
                                                                PostController>()
                                                            .checkDateIsSame(
                                                                dateTime!,
                                                                DateTime.now());
                                                        if (!isSame) {
                                                          Get.find<
                                                                  PostController>()
                                                              .deletePostByWriteDate(
                                                                  dateTime);
                                                        } else {
                                                          ToastList
                                                              .showCantDeleteToast();
                                                        }
                                                        Get.back();
                                                      },
                                                      noAction: () {
                                                        Get.back();
                                                      });
                                            }),
                                    child: const Icon(Icons.more_vert_rounded))
                                : Container(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: StaggeredImageView(
                          imagelist: imagelist,
                          dateTime: writeDate,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      content.isNotEmpty
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Center(
                                child: Image.asset(
                                    'lib/assets/image/back_card/click_timer.png'),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: HashTagText(
                          text: content,
                          basicStyle: const TextStyle(
                              color: Colors.black, fontSize: 20),
                          decoratedStyle:
                              const TextStyle(color: Colors.blue, fontSize: 20),
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
}
