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
    required this.image,
    required this.writeDate,
    required this.duration,
  }) : super(key: key);

  final String title;
  final String content;
  final File? image;
  final DateTime? writeDate;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 15,
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
                  image: image,
                  writeDate: writeDate,
                ),
                back: BackCard(
                  title: title,
                  content: content,
                  duration: duration,
                  image: image,
                  writeDate: writeDate,
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
