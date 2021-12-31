import 'dart:io';

import 'package:fifteen_minute_diary/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryCardViewWidget extends StatelessWidget {
  DiaryCardViewWidget(
      {required this.title, required this.content, required this.image});

  final String title;
  final String content;
  final File image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width,
        height: Get.height / 3,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3,
          color: Colors.orangeAccent.shade400,
          child: Row(
            //TODO 반전 포맷도 하나 만들기
            children: [
              Flexible(
                  child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    image: DecorationImage(
                        image: FileImage(image), fit: BoxFit.fill)),
              )),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title.toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Text("?시 ??분"),
                          ],
                        ),
                        Center(
                          child: Text(content),
                        ),
                        Text("12분동안 작성...")
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
