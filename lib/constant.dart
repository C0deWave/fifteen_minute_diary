// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:flutter/material.dart';

/*
 * 각종 설정을 변경하기 위한 상수 모음 입니다.
 */

//---------------------------------------------------
// 전역 설정
const k_TimerTotalDuration = 15 * 60;

//---------------------------------------------------
// init_splash_screen
// 처음 앱을 실행했는지 확인하기 위한 Shared_preference의 키값입니다.
const k_IsViewSplashViewKey = "testIsViewSplashView50";
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
// 기본이미지의 개수
const k_StandardImageLength = 15;
// 시간값이 없는경우 항상 큰값으로 인정합니다.
const k_SortRight = 1;
// 일기를 쓰지 않았을 경우 생기는 탬플릿입니다.
Post k_NotWritePost = Post(
    title: "오늘 일기를 작성해 주세요",
    content: "",
    duration: 0,
    writeDate: null,
    imagelist: null,
    hashtags: []);

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

//----------------------------------------------------------------
//firebase_service
// shared preference 키
const k_OAuthProvider = 'OAuthProvider';
const k_ProviderApple = 'apple';
const k_ProviderGoogle = 'google';
const k_ProviderNull = 'null';

//-------------------------------------------------------------------
// dialog_list
const List<String> k_topiclist = [
  '"오늘 먹은 음식은 어땠나요?"',
  '"최근에 가장 행복한 일이 뭐였나요?"',
  '"나를 힘차게 하는 것들은 무엇이 있나요?"',
  '"오늘의 고마운 점 3가지"',
  '"오랫만에 하고 싶은 게임이 있나요?"',
  '"10년 뒤의 나에게 보내는 편지"',
  '"내가 철들었구나 싶을때는?"',
  '"내가 제일 좋아하는 동물은?"',
  '"무인도에 가져갈 물건 5가지"',
  '"올해의 목표 돌아보기"',
  '"나에게 한달의 자유가 있다면?"',
  '"내가 가장 듣고 싶은 칭찬은?"',
  '"내가 생각하는 완벽한 내 모습은?"',
  '"나의 성장을 방해하는 것은?"',
  '"시 한편 지어보기"',
  '"오늘이 의미있는 이유"',
  '"당장 여행가고 싶은 장소는?"',
  '"내 인생에서 가장 큰 거짓말은?"',
  '"내가 꾸고 싶은 꿈은?"',
  '"복권에 당첨 된다면?"',
  '"제일 가지고 싶은 초능력은?"',
  '"나만의 인생영화는?"',
  '"내가 가장 행복한 시절은?"',
  '"오늘의 하늘 풍경"',
  '"기르고 싶은 동물은?"',
  '"산타클로스에게 선물을 받는다면?"',
  '"내가 제일 좋아하는 연애인은?"',
  '"나에게 만원만 있다면?"',
  '"부모님께 효도 하나 하고 후기"',
  '"내 보물 1호는?"',
];
