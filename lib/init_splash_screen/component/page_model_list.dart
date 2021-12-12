import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

var listPagesViewModel = <PageViewModel>[
  PageViewModel(
    title: "하루의 1%를 투자하세요",
    body: "15Minute Diary는 15분의 시간제한을 두고 쓰는 일기장 앱입니다.",
    image: Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Center(
        child: Image.network(
          "https://image.yes24.com/images/00_Event/2021/yesPresent/0623Miracle/img001.jpg",
          fit: BoxFit.fill,
        ),
      ),
    ),
  ),
  PageViewModel(
    title: "Title of first page",
    body:
        "Here you can write the description of the page, to explain someting...",
    image: Center(
      child: Image.network(
          "https://lh3.googleusercontent.com/proxy/3tcAIoY9mkIZ_H9UZyStrTcLtTPkxu-C4pyed7JrLOmnjm2lTZu2xBTKTIH0osztwpldpp1ytW5rulv24aSY42gjGKKPpDyKZqOTw89CspWi-D33O_Q",
          height: 400.0),
    ),
  ),
];
