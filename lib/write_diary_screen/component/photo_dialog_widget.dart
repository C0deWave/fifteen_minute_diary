import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/post_controller.dart';

class PhotoDialogWidget extends StatelessWidget {
  final String _tag = 'PhotoDialogWidget: ';
  const PhotoDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    return Stack(children: [
      Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "사진 추가",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        List<XFile> imageList = [];
                        Get.find<PostController>()
                            .changePostIndicatorState(true);
                        final XFile? photo =
                            await _picker.pickImage(source: ImageSource.camera);
                        if (photo != null) {
                          imageList.add(photo);
                          Get.find<PostController>()
                              .updateSelectImage(imageList);
                          Get.find<PostController>()
                              .changeImageWidgetStatus(true);
                        }
                        Get.find<PostController>()
                            .changePostIndicatorState(false);
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        height: 140,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: FittedBox(
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.find<PostController>()
                            .changePostIndicatorState(true);
                        // final XFile? image = await _picker.pickImage(
                        //     source: ImageSource.gallery);
                        final List<XFile>? imageList =
                            await _picker.pickMultiImage();
                        if (imageList != null) {
                          Get.find<PostController>()
                              .updateSelectImage(imageList);
                          Get.find<PostController>()
                              .changeImageWidgetStatus(true);
                        }
                        Get.find<PostController>()
                            .changePostIndicatorState(false);
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        height: 140,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: FittedBox(
                            child: Icon(
                              Icons.add_photo_alternate_rounded,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      debugPrint(_tag + "click");
                      Get.find<PostController>().deleteImage();
                      Get.back();
                    },
                    child: const Text("이미지 삭제")),
              ],
            ),
          ),
        ),
      ),
      GetBuilder<PostController>(builder: (_) {
        if (_.getIsShowIndicator()) {
          return Container(
              color: const Color(0x00000000),
              child: const Center(
                  child: CupertinoActivityIndicator(
                color: Colors.black,
              )));
        } else {
          return Container();
        }
      }),
    ]);
  }
}
