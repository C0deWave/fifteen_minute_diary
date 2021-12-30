import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleTextFieldWidget extends GetView<PostController> {
  const TitleTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PostController>();
    return Center(
      child: TextField(
        focusNode: controller.getTitleFocusController(),
        controller: controller.getTitleController(),
        onEditingComplete: () {
          controller.completeTitleWrite();
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        maxLines: 1,
        minLines: 1,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          hintText: "제목을 적어주세요.",
          border: UnderlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
