import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  //쓴 일기를 추출하는데 사용합니다.
  var titleController = TextEditingController();
  var contextController = TextEditingController();
  // 포커스 전환을 하는데 사용합니다.
  var titleFocusController = FocusNode();
  var contextFocusController = FocusNode();

  TextEditingController getTitleController() => titleController;
  TextEditingController getContextController() => contextController;
  FocusNode getTitleFocusController() => titleFocusController;
  FocusNode getContextFocusController() => contextFocusController;

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
