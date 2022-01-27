import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';

class ContextTextFieldWidget extends StatelessWidget {
  const ContextTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PostController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: HashTagTextField(
          controller: controller.getContextController(),
          focusNode: controller.getContextFocusController(),
          keyboardType: TextInputType.multiline,
          minLines: 17, //Normal textInputField will be displayed
          maxLines: 200,
          basicStyle: const TextStyle(fontSize: 18),
          decoratedStyle: const TextStyle(fontSize: 18, color: Colors.blue),
          decoration: const InputDecoration(
            hintText: "15분간 일기를 써 주세요.\n#해시 #태그 #가능",
            border: UnderlineInputBorder(borderSide: BorderSide.none),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
          )),
    );
  }
}
