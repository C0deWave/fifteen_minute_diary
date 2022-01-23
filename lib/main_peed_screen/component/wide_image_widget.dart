import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fifteen_minute_diary/controller/wide_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WideImageWidget extends StatelessWidget {
  WideImageWidget(
      {Key? key, required this.imagelist, required this.indexNumber})
      : super(key: key);
  List<File>? imagelist;
  int indexNumber;
  @override
  Widget build(BuildContext context) {
    var imagedata = imagelist?.map((e) => Image.file(e)).toList();
    return Scaffold(
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
        title: GetBuilder<WideImageController>(
          builder: (controller) {
            return Text(
              "${controller.getIndexNumber().toString()}/${imagelist?.length}",
              style: const TextStyle(color: Colors.white, fontSize: 16),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CarouselSlider(
                items: imagedata,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    Get.find<WideImageController>().setIndexNumber(index + 1);
                  },
                  initialPage: indexNumber - 1,
                  enableInfiniteScroll: false,
                  aspectRatio: 1,
                  viewportFraction: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
