import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WideImageWidget extends StatefulWidget {
  WideImageWidget({Key? key, this.imagelist}) : super(key: key);
  List<File>? imagelist;

  @override
  State<WideImageWidget> createState() => _WideImageWidgetState();
}

class _WideImageWidgetState extends State<WideImageWidget> {
  int pagenumber = 1;
  @override
  Widget build(BuildContext context) {
    var imagedata = widget.imagelist?.map((e) => Image.file(e)).toList();
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
        title: Text(
          "$pagenumber/${widget.imagelist?.length}",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: GestureDetector(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CarouselSlider(
                  items: imagedata,
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        pagenumber = index + 1;
                      });
                    },
                    enableInfiniteScroll: false,
                    aspectRatio: 1,
                    viewportFraction: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
