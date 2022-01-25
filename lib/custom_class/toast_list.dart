import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastList {
  static void showDataUploadToast() {
    debugPrint('show Toast Message');
    Fluttertoast.showToast(
        msg: "데이터를 업로드 합니다.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade800,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showNotHaveRemainTimeToast() {
    debugPrint('show Toast Message');
    Fluttertoast.showToast(
        msg: "남은 시간이 없습니다.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade800,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void show1MinuteRemainToast() {
    debugPrint('show Toast Message');
    Fluttertoast.showToast(
        msg: "1분 남았습니다.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade800,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showCantDeleteToast() {
    Fluttertoast.showToast(
        msg: "오늘 일기는 삭제할 수 없습니다.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade800,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showRequireUserCreditialToast() {
    Fluttertoast.showToast(
        msg: "계정 탈퇴를 위해 재 로그인을 시도합니다.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade800,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // 이미지 5개 제한 Toast 메세지
  static void showLimitFiveImageToast() {
    debugPrint('이미지 5개 제한 toast');
    Fluttertoast.showToast(
        msg: "이미지는 5개 까지만 선택할 수 있습니다.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey.shade700,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
