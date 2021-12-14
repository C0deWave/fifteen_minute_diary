import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../constant.dart';

var listPagesViewModel = <PageViewModel>[
  PageViewModel(
    title: "하루의 1%를 투자하세요",
    body: "15Minute Diary는 15분의 \n시간제한이 있는 일기장 앱입니다.",
    image: Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Center(
        child: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              color: initSplashBackgroundImageColor,
              shape: initSplashImageShape,
              image: DecorationImage(
                image: Svg(
                    "asset/image/init_splash_screen/init1page_notebook.svg"),
              )),
        )),
      ),
    ),
  ),
  PageViewModel(
    title: "15분만 쓸 수 있음에 주의하세요!",
    body: "15분은 하루의 1%정도 입니다.\n15분이 지나면 강제로 일기가 저장됩니다.",
    image: Center(
      child: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            shape: initSplashImageShape,
            color: initSplashBackgroundImageColor,
            image: DecorationImage(
              image: Svg("asset/image/init_splash_screen/init3page_notify.svg"),
            )),
      )),
    ),
  ),
  PageViewModel(
    title: "당신의 지난 날을 되돌아 보세요",
    body: "매일 1%의 시간동안 기록하지만 \n당신은 100%를 기억할 수 있습니다.",
    image: Center(
      child: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            color: initSplashBackgroundImageColor,
            shape: initSplashImageShape,
            image: DecorationImage(
              image:
                  Svg("asset/image/init_splash_screen/init2page_camping.svg"),
            )),
      )),
    ),
  ),
];
