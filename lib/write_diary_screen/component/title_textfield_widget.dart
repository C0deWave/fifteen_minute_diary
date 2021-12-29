import 'package:flutter/material.dart';

class TitleTextFieldWidget extends StatelessWidget {
  const TitleTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        maxLines: 1,
        minLines: 1,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: "제목을 적어주세요.",
          border: UnderlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
