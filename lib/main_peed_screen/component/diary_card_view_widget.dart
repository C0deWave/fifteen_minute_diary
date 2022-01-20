import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/back_card.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/front_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class DiaryCardViewWidget extends StatelessWidget {
  const DiaryCardViewWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.imageList,
    required this.writeDate,
    required this.duration,
    required this.dateTime,
  }) : super(key: key);

  final String title;
  final String content;
  final List<File>? imageList;
  final DateTime? writeDate;
  final int duration;
  final DateTime? dateTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            writeDate != null
                ? formatDate(writeDate!,
                    [yyyy, '년 ', m, '월 ', dd, "일 ", hh, ':', nn, '분에 작성'])
                : '',
            style: const TextStyle(color: Colors.black),
          ),
          Expanded(
            child: FlipCard(
                front: FrontCard(
                  title: title,
                  content: content,
                  duration: duration,
                  image: imageList?[0],
                  writeDate: writeDate,
                ),
                back: BackCard(
                  title: title,
                  content: content,
                  duration: duration,
                  imagelist: imageList,
                  writeDate: writeDate,
                  dateTime: dateTime,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
