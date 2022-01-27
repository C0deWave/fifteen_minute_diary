import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DiaryCardFront extends StatelessWidget {
  const DiaryCardFront(
      {Key? key,
      required this.title,
      required this.content,
      required this.image,
      required this.writeDate,
      required this.duration,
      required this.hashtags})
      : super(key: key);

  final String title;
  final String content;
  final File? image;
  final DateTime? writeDate;
  final int duration;
  final List<String> hashtags;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 1,
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  image: (image != null)
                      ? DecorationImage(
                          image: FileImage(image!), fit: BoxFit.cover)
                      : const DecorationImage(
                          image: NetworkImage(
                              'https://t1.daumcdn.net/cfile/tistory/99F6FC465D4563E132'),
                          fit: BoxFit.fill))),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color.fromARGB(50, 0, 0, 0)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [getHashtagColumn(), showWriteDuration()],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: AutoSizeText(
                title.toString(),
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column getHashtagColumn() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: hashtags
            .getRange(0, hashtags.length >= 3 ? 3 : hashtags.length)
            .map(
              (e) => Text(
                e.length > 10 ? e.substring(0, 10) + '...' : e,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            )
            .toList());
  }

//PostController 하부로 이동
  Text showWriteDuration() {
    if (duration >= 60) {
      return Text(
        "${(duration ~/ 60)}분 ${duration % 60}초 동안 작성",
        style: const TextStyle(color: Colors.white),
      );
    } else if (duration == 0) {
      return const Text(
        "오늘 하루는 어땠나요?",
        style: TextStyle(color: Colors.white),
      );
    }
    return Text(
      "${duration % 60}초 동안 작성",
      style: const TextStyle(color: Colors.white),
    );
  }
}
