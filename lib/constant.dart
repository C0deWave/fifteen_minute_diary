// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/*
 * 각종 설정을 변경하기 위한 상수 모음 입니다.
 */

//---------------------------------------------------
// 전역 설정
// 디버그 로그를 출력하게 함
const k_DebugMode = true;
//Hive Database의 박스 키값입니다.
const k_PostBox = 'testpostbox9';

//---------------------------------------------------
// init_splash_screen
// 처음 앱을 실행했는지 확인하기 위한 Shared_preference의 키값입니다.
const k_IsViewSplashViewKey = "testIsViewSplashView20";
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
// 일기 타이머의 시간 값 입니다.
const k_TimerDuration = 15 * 60;

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
