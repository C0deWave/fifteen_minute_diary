import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  //쓴 일기를 추출하는데 사용합니다.
  var titleController = TextEditingController();
  var contextController = TextEditingController();
  // 이미지를 선택했는지 확인하는 용도로 사용
  bool isUsedImage = false;

  // 선택한 이미지 파일
  late XFile selectedImage;

  // 포커스 전환을 하는데 사용합니다.
  var titleFocusController = FocusNode();
  var contextFocusController = FocusNode();

  TextEditingController getTitleController() => titleController;
  TextEditingController getContextController() => contextController;
  FocusNode getTitleFocusController() => titleFocusController;
  FocusNode getContextFocusController() => contextFocusController;

  //이미지 사용중으로 변경
  void changeImageWidgetStatus(bool status) {
    isUsedImage = status;
    print("이미지 상태 업데이트");
    update();
  }

  // 이미지 변경
  void updateSelectImage(XFile? imageData) {
    if (imageData != null) {
      selectedImage = imageData;
      print("이미지 데이터를 업로드 합니다.");
    }
  }

  // 재목에서 내용으로 포커스 전환
  void completeTitleWrite() {
    print("data");
    contextFocusController.requestFocus();
  }

  void completeContextWrite() {
    print("complete");
  }
}

class PostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostController());
  }
}
