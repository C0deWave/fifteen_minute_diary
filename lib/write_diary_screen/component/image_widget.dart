import 'dart:io';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageWidget extends StatelessWidget {
  final String _tag = 'ImageWidget: ';
  const ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(builder: (controller) {
      return controller.getIsUsedImage()
          ? GetBuilder<PostController>(builder: (controller) {
              if (controller.getSelectedImageList() != null) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List<Widget>.generate(
                          controller.getSelectedImageList()!.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  debugPrint(_tag + "tab");
                                  showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CupertinoActionSheet(
                                            title: const Text('사진 선택'),
                                            // message: const Text('사진은 최대 5장까지 가능합니다.'),
                                            actions: <
                                                CupertinoActionSheetAction>[
                                              CupertinoActionSheetAction(
                                                child: const Text('대표 이미지로 지정'),
                                                onPressed: () async {
                                                  Get.find<PostController>()
                                                      .setRepresentativeImage(
                                                          index);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              CupertinoActionSheetAction(
                                                child: const Text(
                                                  '이미지 삭제',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () async {
                                                  Get.find<PostController>()
                                                      .removeImageOfIndex(
                                                          index);
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          ));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: FileImage(File(controller
                                                    .getSelectedImageList()![
                                                        index]
                                                    .path))),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: index == 0
                                                ? Border.all(
                                                    width: 2,
                                                    color: Colors.orange)
                                                : Border.all(
                                                    width: 0.2,
                                                    color: Colors.black)),
                                      ),
                                      Text(
                                        index == 0 ? "대표이미지" : "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ))),
                );
              } else {
                return Container();
              }
            })
          : Container();
    });
  }
}
