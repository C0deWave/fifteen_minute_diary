import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:fifteen_minute_diary/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryCardViewWidget extends StatelessWidget {
  DiaryCardViewWidget(
      {required this.title,
      required this.content,
      required this.image,
      required this.writeDate,
      required this.duration});

  final String title;
  final String content;
  final File image;
  final DateTime writeDate;
  final int duration;

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
                    borderRadius: const BorderRadius.only(
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
                            Text(formatDate(writeDate, [
                              yyyy,
                              '년',
                              mm,
                              '월',
                              dd,
                              "일  ",
                              hh,
                              ':',
                              nn,
                              ''
                            ])),
                          ],
                        ),
                        Center(
                          child: Text(content),
                        ),
                        Text("${(duration ~/ 60)}분 ${duration % 60}초 동안 작성")
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
