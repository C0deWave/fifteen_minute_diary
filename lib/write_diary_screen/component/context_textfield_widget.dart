import 'package:flutter/material.dart';

class ContextTextFieldWidget extends StatelessWidget {
  const ContextTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: TextField(
          keyboardType: TextInputType.multiline,
          minLines: 7, //Normal textInputField will be displayed
          maxLines: 7,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            hintText: "15분간 일기를 써 주세요.",
            border: UnderlineInputBorder(borderSide: BorderSide.none),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
          )),
    );
  }
}
