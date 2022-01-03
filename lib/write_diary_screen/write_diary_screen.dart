import 'package:fifteen_minute_diary/write_diary_screen/component/context_textfield_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/hero_timer_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/image_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/title_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'component/photo_dialog_widget.dart';

class WriteDiaryScreen extends StatelessWidget {
  const WriteDiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_a_photo),
          onPressed: () {
            Get.dialog(const PhotoDialogWidget());
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: const [
                HeroTimerWidget(),
                ImageWidget(),
                TitleTextFieldWidget(),
                ContextTextFieldWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
