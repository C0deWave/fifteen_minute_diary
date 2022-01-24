import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:fifteen_minute_diary/controller/wide_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WideImageWidget extends StatelessWidget {
  WideImageWidget(
      {Key? key,
      required this.imagelist,
      required this.dateTime,
      required this.indexNumber})
      : super(key: key);
  List<File>? imagelist;
  int indexNumber;
  DateTime dateTime;
  @override
  Widget build(BuildContext context) {
    var imagedata = imagelist
        ?.map((e) => Image.file(
              e,
              fit: BoxFit.fitWidth,
            ))
        .toList();
    return GetBuilder<WideImageController>(
      builder: (controller) => Hero(
        tag: dateTime.toString() +
            Get.find<WideImageController>().getIndexNumber().toString(),
        child: DismissiblePage(
          isFullScreen: true,
          onDismiss: () => Get.back(),
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 28,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              title: Text(
                "${controller.getIndexNumber().toString()}/${imagelist?.length}",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.black,
                  child: Center(
                    child: CarouselSlider(
                      items: imagedata,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          Get.find<WideImageController>()
                              .setIndexNumber(index + 1);
                        },
                        initialPage: indexNumber - 1,
                        enableInfiniteScroll: false,
                        height: Get.height * 0.7,
                        // aspectRatio: 9 / 16,
                        viewportFraction: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
