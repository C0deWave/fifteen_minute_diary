// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:flutter/material.dart';

/*
 * 각종 설정을 변경하기 위한 상수 모음 입니다.
 */

//---------------------------------------------------
// 전역 설정
//Hive Database의 Post내용을 담는 박스 키값입니다.
const k_PostBox = 'testpostbox29';

const k_TimerTotalDuration = 15 * 60;

//---------------------------------------------------
// init_splash_screen
// 처음 앱을 실행했는지 확인하기 위한 Shared_preference의 키값입니다.
const k_IsViewSplashViewKey = "testIsViewSplashView27";
// splash 화면의 배경입니다.
const k_InitSplashBackgroundImageColor = Colors.white12;
// splash 이미지의 모양입니다. circle로 설정하면 원으로 바뀝니다.
const k_InitSplashImageShape = BoxShape.rectangle;

//---------------------------------------------------
// write_diary_screen
// Hero 애니메이션을 위한 Timer key값입니다.
const k_TimerHerotag = "TimerHeroWidgetTest";

//---------------------------------------------------
// timer_controller
// 1초 입니다.
const k_OneSec = Duration(seconds: 1);

//---------------------------------------------------
// post_controller
// 시간값이 없는경우 항상 큰값으로 인정합니다.
const k_SortRight = 1;
// 일기를 쓰지 않았을 경우 생기는 탬플릿입니다.
Post k_NotWritePost = Post(
    title: "오늘 일기를 작성해 주세요",
    content: "",
    duration: 0,
    writeDate: null,
    image: null);

//---------------------------------------------------
// timer_complete_alert
// alert 제목
const k_AlertTitle = "일기 종료";
// alert 내용 1,2 => 사이에 HH:mm 형태의 시간포맷 존재
const k_AlertContent1 = "시간이 ";
const k_AlertContent2 = "초 남았어요.\n다 쓰셨나요?";
// alert yes 텍스트
const k_AlertYes = "넵";
// alert no 텍스트
const k_AlertNo = "아니요";
// alert cancle 텍스트
const k_AlertCancle = "다음에 쓸래요!";
