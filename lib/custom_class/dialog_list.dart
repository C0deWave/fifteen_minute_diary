import 'dart:io';

import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/controller/timer_controller.dart';
import 'package:fifteen_minute_diary/custom_class/camera_and_image_picker.dart';
import 'package:fifteen_minute_diary/custom_class/firebase_service.dart';
import 'package:fifteen_minute_diary/custom_class/hive_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;

class DialogList {
  // 일기 추천 dialog
  static void showIosDailyTopic(BuildContext context, int topicIndex,
      {required Function okFunction}) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          '오늘의 일기 주제',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          children: [
            Text(k_topiclist[topicIndex]),
            const Text('확인을 누르면 바로 일기를 쓰러 이동합니다.'),
          ],
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () async {
              Get.back();
            },
          ),
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: () async {
              Get.find<PostController>()
                  .updateTitleText(k_topiclist[topicIndex]);
              Get.back();
              okFunction();
            },
          )
        ],
      ),
    );
  }

  // 안드로이드 일기 추천 dialog
  static void showAndroidDailyTopic(BuildContext context, int topicIndex,
      {required Function okFunction}) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          '오늘의 일기 주제',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
            child: ListBody(
          children: [
            Text(k_topiclist[topicIndex]),
            const Text('확인을 누르면 바로 일기를 쓰러 이동합니다.'),
          ],
        )),
        actions: [
          TextButton(
            child: const Text('취소'),
            onPressed: () async {
              Get.back();
            },
          ),
          TextButton(
            child: const Text('확인'),
            onPressed: () async {
              Get.find<PostController>()
                  .updateTitleText(k_topiclist[topicIndex]);
              Get.back();
              okFunction();
            },
          )
        ],
      ),
    );
  }

  //이름 변경 dialog
  static void showIosChangeWhatName(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          '유저명',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoTextField(
            controller: textEditingController,
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: () async {
              if (textEditingController.text.isNotEmpty) {
                FirebaseService().updateUserName(textEditingController.text);
              }
              Get.back();
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('취소'),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }

  // 계정탈퇴 dialog
  static void showIosLeaveAccountDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          '계정 탈퇴',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        content: const Text(
            '계정정보, 일기, 백업데이터를 삭제합니다.\n삭제된 데이터는 복구할 수 없습니다.\n계정을 삭제하기 위해 재로그인이 필요합니다.'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () async {
              Get.back();
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('확인'),
            onPressed: () async {
              //파이어베이스유저DB / 계정삭제
              Get.find<PostController>().deletePostListAll();
              await HiveDataBase().clearHiveDatabase();
              //파이어베이스 백업, 이미지, 계정이미지, 계정 데이터 삭제
              await FirebaseService().deleteUser();
              Get.back();
            },
          )
        ],
      ),
    );
  }

  //이미지 선택 dialog
  static void showIosWhereSelectImage(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('이미지 선택'),
        content: const Text('어디에서 이미지를 가져올까요?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('카메라'),
            onPressed: () async {
              File? data = await CameraAndImagePicker.selectFromCamera();
              if (data != null) {
                FirebaseService().updateUserImage(data);
              }
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('앨범'),
            onPressed: () async {
              File? data = await CameraAndImagePicker.selectFromAlbum();
              if (data != null) {
                FirebaseService().updateUserImage(data);
              }
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  // ios 일기 다씀 확인 alert
  static void showIosWriteCheckAlert({
    required BuildContext context,
    required Function() yesAction,
    required Function() noAction,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text(k_AlertTitle),
        content: Text(k_AlertContent1 +
            Get.find<TimerController>().getTimeText().value +
            k_AlertContent2),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text(k_AlertYes),
            onPressed: yesAction,
          ),
          CupertinoDialogAction(
            child: const Text(k_AlertNo),
            onPressed: noAction,
          ),
        ],
      ),
    );
  }

  // 안드로이드 일기 다씀 확인
  static void showAndroidWriteCheckAlert({
    required BuildContext context,
    required Function() yesAction,
    required Function() noAction,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(k_AlertTitle),
        content: Text(k_AlertContent1 +
            Get.find<TimerController>().getTimeText().value +
            k_AlertContent2),
        actions: <Widget>[
          TextButton(
            child: const Text(k_AlertYes),
            onPressed: yesAction,
          ),
          TextButton(
            child: const Text(k_AlertNo),
            onPressed: noAction,
          ),
        ],
      ),
    );
  }

  // IOS 일기 삭제 확인 Dialog
  static void showIosDeleteDiaryAlert({
    required BuildContext context,
    required Function() yesAction,
    required Function() noAction,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('일기 삭제'),
        content: Text('일기를 삭제하시겠습니까?\n백업이 안 됐을 경우 되돌릴 수 없습니다.'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('확인'),
            isDestructiveAction: true,
            onPressed: yesAction,
          ),
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: noAction,
          ),
        ],
      ),
    );
  }

  // 플랫폼 확인 코드 추가하기
  static void showBackUpStartDiaryAlert({
    required BuildContext context,
    required Function() yesAction,
    required Function() noAction,
  }) {
    foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS
        ? showIosBackUpStartDiaryAlert(
            context: context, yesAction: yesAction, noAction: noAction)
        : showAndroidBackUpStartDiaryAlert(
            context: context, yesAction: yesAction, noAction: noAction);
  }

  // IOS 일기 백업 Dialog
  static void showIosBackUpStartDiaryAlert({
    required BuildContext context,
    required Function() yesAction,
    required Function() noAction,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('백업 올리기'),
        content: Text('데이터를 서버에 백업 할까요?\n기존 백업 내용은 지워집니다.'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: yesAction,
          ),
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: noAction,
          ),
        ],
      ),
    );
  }

  // Android 일기 백업 Dialog
  static void showAndroidBackUpStartDiaryAlert({
    required BuildContext context,
    required Function() yesAction,
    required Function() noAction,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('백업 올리기'),
        content: Text('데이터를 서버에 백업 할까요?\n기존 백업 내용은 지워집니다.'),
        actions: <Widget>[
          TextButton(
            child: const Text('확인'),
            onPressed: yesAction,
          ),
          TextButton(
            child: const Text('취소'),
            onPressed: noAction,
          ),
        ],
      ),
    );
  }

  // IOS 일기 백업 다운로드
  static void showIosBackUpDownloadDiaryAlert({
    required BuildContext context,
    required Function() yesAction,
    required Function() noAction,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('백업 내려받기'),
        content: Text('백업 데이터를 불러올까요?\n기존 일기가 지워질 수 있습니다.'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: yesAction,
          ),
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: noAction,
          ),
        ],
      ),
    );
  }

  // IOS 메일 안내 메세지
  static void showIosReportMailAlert({
    required BuildContext context,
    required Function() yesAction,
    required Function() noAction,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('개발자에게 의견제시'),
        content: const Text(
            '각종 버그나 의견이 있다면 말해주세요.\n감성 사진도 보내 주시면 추후 업데이트에 반영하겠습니다.'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: yesAction,
          ),
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: noAction,
          ),
        ],
      ),
    );
  }
}
