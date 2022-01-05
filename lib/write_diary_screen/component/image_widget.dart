import 'dart:io';

import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/photo_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageWidget extends StatelessWidget {
  final String _tag = 'ImageWidget: ';
  const ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(builder: (controller) {
      return controller.getIsUsedImage()
          ? GestureDetector(
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
                            File(controller.getSelectedImage()!.path))),
                    borderRadius: BorderRadius.circular(15)),
              ),
            )
          : Container();
    });
  }
}
