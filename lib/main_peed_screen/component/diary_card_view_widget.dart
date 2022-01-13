import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class DiaryCardViewWidget extends StatelessWidget {
  const DiaryCardViewWidget(
      {Key? key,
      required this.title,
      required this.content,
      required this.image,
      required this.writeDate,
      required this.duration})
      : super(key: key);

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
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 1,
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          image: (image != null)
                              ? DecorationImage(
                                  image: FileImage(image!), fit: BoxFit.fill)
                              : const DecorationImage(
                                  image: NetworkImage(
                                      'https://t1.daumcdn.net/cfile/tistory/99F6FC465D4563E132'),
                                  fit: BoxFit.fill))),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0x35000000)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  title.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              content,
                              maxLines: 17,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),
                        showWriteDuration()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

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
