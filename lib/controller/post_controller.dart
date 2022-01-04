// ignore_for_file: avoid_print

import 'dart:io';
import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/custom_class/hive_database.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  //쓴 일기를 추출하는데 사용합니다.
  var titleController = TextEditingController();
  var contextController = TextEditingController();
  // 이미지를 선택했는지 확인하는 용도로 사용
  bool isUsedImage = false;
  //인디케이터 확인용 코드
  bool isShowIndicator = false;
  // 선택한 이미지 파일
  late XFile? selectedImage;
  // 포커스 전환을 하는데 사용합니다.
  var titleFocusController = FocusNode();
  var contextFocusController = FocusNode();
  //Post게시글 리스트
  List<Post> postlist = [];
  //Post list Hive 저장소
  late HiveDataBase postBox;

  // getMethod
  TextEditingController getTitleController() => titleController;
  TextEditingController getContextController() => contextController;
  FocusNode getTitleFocusController() => titleFocusController;
  FocusNode getContextFocusController() => contextFocusController;

  Future<void> addPostList(DateTime writeDate, int duration) async {
    if (titleController.text.isNotEmpty && contextController.text.isNotEmpty) {
      Post temp = Post(
          title: titleController.text,
          content: contextController.text,
          image: File(selectedImage!.path),
          writeDate: writeDate,
          duration: duration);
      var postIndexKey = (writeDate.year.toString() +
          addZero(writeDate.month) +
          addZero(writeDate.day));
      postlist.add(temp);
      // await postBox.add(temp);
      postBox.pushPostToHive(postIndexKey, temp);
      if (k_DebugMode) {
        print(postIndexKey);
        print("postBox크기 ${postBox.getLength()}");
      }
      resetWriteState();
      update();
      if (k_DebugMode) {
        print("이미지가 저장되었습니다.");
      }
    }
  }

  void changePostIndicatorState(bool state) {
    isShowIndicator = state;
    update();
  }

  void resetWriteState() {
    titleController.clear();
    contextController.clear();
    isUsedImage = false;
    selectedImage = null;
    update();
  }

  // 지정된 이미지를 삭제
  void deleteImage() {
    selectedImage = null;
    isUsedImage = false;
    update();
  }

  //이미지 사용중으로 변경
  void changeImageWidgetStatus(bool status) {
    isUsedImage = status;
    if (k_DebugMode) {
      print("이미지 상태 업데이트");
    }
    update();
  }

  // 이미지 변경
  void updateSelectImage(XFile? imageData) {
    if (imageData != null) {
      selectedImage = imageData;
      if (k_DebugMode) {
        print("이미지 데이터를 업로드 합니다.");
      }
    }
  }

  // 재목에서 내용으로 포커스 전환
  void completeTitleWrite() {
    if (k_DebugMode) {
      print("data");
    }
    contextFocusController.requestFocus();
  }

  void completeContextWrite() {
    if (k_DebugMode) {
      print("complete");
    }
  }

  @override
  void onInit() async {
    // Here you can fetch you product from server
    if (k_DebugMode) {
      print('postBox controller 주입');
    }
    postBox = HiveDataBase();
    for (var i = 0; i < postBox.getLength(); i++) {
      var temp = postBox.getAtPost(i);
      if (temp != null) {
        postlist.add(temp);
      }
    }
    // 저장소에서 꺼내온 일기를 시간순으로 정렬
    postlist.sort((Post temp1, Post temp2) {
      return temp1.writeDate.compareTo(temp2.writeDate);
    });
    super.onInit();
  }

  @override
  void onClose() {
    postBox.closeDatabase();
    super.onClose();
  }

  String addZero(int num) {
    if (num < 10) {
      return "0$num";
    }
    return "$num";
  }
}

class PostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostController());
  }
}
