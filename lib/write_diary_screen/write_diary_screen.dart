import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/context_textfield_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/hero_timer_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/image_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/component/title_textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
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
            showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) => CupertinoActionSheet(
                title: const Text('사진 선택'),
                // message: const Text('사진은 최대 5장까지 가능합니다.'),
                actions: <CupertinoActionSheetAction>[
                  CupertinoActionSheetAction(
                    child: const Text('카메라에서 선택'),
                    onPressed: () async {
                      XFile? selectedImage =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (selectedImage != null) {
                        Get.find<PostController>()
                            .addSelectImage(selectedImage);
                        Get.find<PostController>()
                            .changeImageWidgetStatus(true);
                      }
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: const Text('앨범에서 선택'),
                    onPressed: () async {
                      final List<XFile>? imageList =
                          await _picker.pickMultiImage();
                      if (imageList != null) {
                        debugPrint(imageList.length.toString() + '개의 이미지 선택');
                        for (var i = 0; i < imageList.length; i++) {
                          Get.find<PostController>()
                              .addSelectImage(imageList[i]);
                        }
                        Get.find<PostController>()
                            .changeImageWidgetStatus(true);
                      } else {
                        debugPrint('선택된 사진이 없습니다.');
                      }
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: const [
                HeroTimerWidget(),
                ImageWidget(),
                SizedBox(height: 6),
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
