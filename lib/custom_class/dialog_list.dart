import 'dart:io';

import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/custom_class/camera_and_image_picker.dart';
import 'package:fifteen_minute_diary/custom_class/firebase_service.dart';
import 'package:fifteen_minute_diary/custom_class/hive_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DialogList {
  // 일기 추천 dialog
  static void showDailyTopic(BuildContext context, int topicIndex,
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

  //이름 변경 dialog
  static void showChangeWhatName(BuildContext context) {
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
  static void showLeaveAccountDialog(BuildContext context) {
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
  static void showWhereSelectImage(BuildContext context) {
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
}
