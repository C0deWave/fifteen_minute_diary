import 'package:fifteen_minute_diary/controller/calendar_controller.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/controller/timer_controller.dart';
import 'package:fifteen_minute_diary/custom_class/action_sheet_list.dart';
import 'package:fifteen_minute_diary/custom_class/toast_list.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/context_textfield_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/hero_timer_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/image_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/title_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class WriteDiaryScreen extends StatelessWidget {
  const WriteDiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_a_photo),
          onPressed: () {
            ActionSheetList.showAddImageSheet(
                context: context,
                chooseCamera: () async {
                  await stopTimer();
                  XFile? selectedImage =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (selectedImage != null) {
                    Get.find<PostController>().addSelectImage(selectedImage);
                    Get.find<PostController>().changeImageWidgetStatus(true);
                  }
                  Navigator.pop(context);
                  await restartTimer();
                },
                chooseAlbum: () async {
                  await stopTimer();
                  final List<XFile>? imageList = await _picker.pickMultiImage();
                  if (imageList != null) {
                    debugPrint(imageList.length.toString() + '개의 이미지 선택');
                    for (var i = 0; i < imageList.length; i++) {
                      Get.find<PostController>().addSelectImage(imageList[i]);
                    }
                    Get.find<PostController>().changeImageWidgetStatus(true);
                  } else {
                    debugPrint('선택된 사진이 없습니다.');
                  }
                  await restartTimer();
                  Navigator.pop(context);
                });
          },
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: CustomScrollView(
              slivers: [
                SliverStickyHeader(
                    header: Container(
                      color: Colors.white,
                      child: Column(
                        children: const [
                          HeroTimerWidget(),
                          ImageWidget(),
                        ],
                      ),
                    ),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, i) => Column(
                                  children: const [
                                    SizedBox(height: 3),
                                    TitleTextFieldWidget(),
                                    ContextTextFieldWidget(),
                                  ],
                                ),
                            childCount: 1)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> restartTimer() async {
    var postController = Get.find<PostController>();
    var timerController = Get.find<TimerController>();
    Get.find<TimerController>().startTimer(finishFunction: () async {
      bool isWritePost = await postController.addPostList(
          writeDuration: timerController.getDuration());
      Get.find<CalendarController>().updateCalenderPostlist();
      isWritePost ? timerController.stopTimer() : timerController.resetTimer();
      Get.back();
    }, remain1MinuteFunction: () {
      ToastList.show1MinuteRemainToast();
    });
  }

  Future<void> stopTimer() async {
    Get.find<TimerController>().stopTimer();
  }
}
