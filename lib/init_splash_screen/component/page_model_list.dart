import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

var listPagesViewModel = <PageViewModel>[
  PageViewModel(
    title: "하루의 1%를 투자하세요",
    body: "15Minute Diary는 15분의 \n시간제한이 있는 일기장 앱입니다.",
    image: Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Center(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(
              "asset/image/init_splash_screen/init1page_studing.svg"),
        )
            // Image.asset(
            //   "/asset/image/init_splash_screen/init1page_studing.svg",
            //   fit: BoxFit.fill,
            // ),
            ),
      ),
    ),
  ),
  PageViewModel(
    title: "당신의 지난 날을 되돌아 보세요",
    body: "매일 1%의 시간동안 기록하지만 \n일기장에는 당신의 100%가 있습니다.",
    image: Center(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SvgPicture.asset(
            "asset/image/init_splash_screen/init2page_camping.svg"),
      )
          // Image.network(
          //     "/asset/image/init_splash_screen/init2page_camping.svg",
          //     height: 400.0),
          ),
    ),
  ),
  PageViewModel(
    title: "15분만 쓸 수 있음에 주의하세요!",
    body: "역설적이게도 일기를 더 잘 쓰게 됩니다.\n15분이 지나면 강제로 일기가 작성됩니다.",
    image: Center(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SvgPicture.asset(
            "asset/image/init_splash_screen/init3page_notify.svg"),
      )
          // Image.network(
          //     "/asset/image/init_splash_screen/init3page_notify.svg",
          //     height: 400.0),
          ),
    ),
  ),
];
