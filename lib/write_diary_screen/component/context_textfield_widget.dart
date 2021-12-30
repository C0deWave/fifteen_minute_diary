import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContextTextFieldWidget extends StatelessWidget {
  const ContextTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PostController>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: TextField(
          controller: controller.getContextController(),
          onEditingComplete: () {
            controller.completeContextWrite();
          },
          focusNode: controller.getContextFocusController(),
          keyboardType: TextInputType.multiline,
          minLines: 7, //Normal textInputField will be displayed
          maxLines: 7,
          style: const TextStyle(fontSize: 18),
          decoration: const InputDecoration(
            hintText: "15분간 일기를 써 주세요.",
            border: UnderlineInputBorder(borderSide: BorderSide.none),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
          )),
    );
  }
}
