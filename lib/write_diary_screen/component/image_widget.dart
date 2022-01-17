import 'dart:io';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/photo_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ImageWidget extends StatelessWidget {
  final String _tag = 'ImageWidget: ';
  const ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(builder: (controller) {
      List<Widget> rowlist2 = List<Widget>.generate(
          Get.find<PostController>().getPostlist()[0].imagelist!.length,
          (index) => Text('${index}'));
      List<Widget> rowlist = [
        GestureDetector(
          onTap: () {
            debugPrint(_tag + "tab");
            Get.dialog(const PhotoDialogWidget());
          },
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: FileImage(
                        File(controller.getSelectedImageList()![0].path))),
                borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ];

      return controller.getIsUsedImage()
          ? GetBuilder<PostController>(builder: (controller) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List<Widget>.generate(
                        controller.getSelectedImageList()!.length,
                        (index) => GestureDetector(
                              onTap: () {
                                debugPrint(_tag + "tab");
                                Get.dialog(const PhotoDialogWidget());
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(File(controller
                                            .getSelectedImageList()![index]
                                            .path))),
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ))),
              );
            })
          : Container();
    });
  }
}
