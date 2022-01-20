import 'dart:io';

import 'package:fifteen_minute_diary/custom_class/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawerController extends GetxController {
  //---------------------------------------------------------
  //변수
  bool _isShowIndicator = false;

  //---------------------------------------------------------
  // 함수
  bool getIsShowIndicator() => _isShowIndicator;

  // 인디케이터 표시 유무
  void setIsShowIndicator(bool state) {
    _isShowIndicator = state;
    update();
  }

  // 개발자에게 메일 보내기
  void mailToDeveloper() async {
    final Uri scheme = Uri(
        scheme: "mailto",
        path: "jamg123123@naver.com",
        query: encodeQueryParameters(<String, String>{
          "subject": "[15Minute Diary] 에러신고",
          "body": "사용하시는 휴대폰 기종, OS와 함께 에러 내용을 적어주세요."
        }));
    if (!await launch(scheme.toString())) throw 'Could not launch $scheme';
  }

  // Uri Query부분의 파라미터 파싱
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  // 이미지 어디서 선택할지 물어보기
  void showWhereSelectImage(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('이미지 선택'),
        content: const Text('어디에서 이미지를 가져올까요?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('카메라'),
            onPressed: () async {
              File? data = await selectFromCamera();
              if (data != null) {
                FirebaseService().updateUserImage(data);
              }
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('앨범'),
            onPressed: () async {
              File? data = await selectFromAlbum();
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

  // 계정정보 변경 BottomSheet
  void showUpdateUserdataModalSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(
                  child: const Text(
                    '대표이미지 선택',
                  ),
                  onPressed: () async {
                    Get.back();
                    showWhereSelectImage(context);
                  },
                ),
                CupertinoActionSheetAction(
                  child: const Text(
                    '이름 변경',
                  ),
                  onPressed: () async {
                    Get.back();
                  },
                ),
                CupertinoActionSheetAction(
                  child: const Text(
                    '계정 탈퇴',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {
                    Get.back();
                  },
                ),
              ],
            ));
  }

  // 카메라에서 이미지를 선택합니다.
  Future<File?> selectFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    XFile? selectedImage = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 200,
        maxHeight: 200,
        imageQuality: 95);
    if (selectedImage == null) {
      return null;
    } else {
      return File(selectedImage.path);
    }
  }

  selectFromAlbum() async {
    final ImagePicker _picker = ImagePicker();
    XFile? selectedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 200,
        maxWidth: 200,
        imageQuality: 95);
    if (selectedImage == null) {
      return null;
    } else {
      return File(selectedImage.path);
    }
  }
}
