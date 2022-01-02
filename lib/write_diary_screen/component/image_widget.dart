import 'dart:io';

import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(builder: (controller) {
      return controller.isUsedImage
          ? Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: FileImage(File(controller.selectedImage!.path))),
                  borderRadius: BorderRadius.circular(15)),
            )
          : Container();
    });
  }
}
