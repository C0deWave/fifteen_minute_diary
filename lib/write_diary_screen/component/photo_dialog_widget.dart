import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/post_controller.dart';

class PhotoDialogWidget extends StatelessWidget {
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
            margin: EdgeInsets.symmetric(horizontal: 20),
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
                        Get.find<PostController>()
                            .changePostIndicatorState(true);
                        final XFile? photo =
                            await _picker.pickImage(source: ImageSource.camera);
                        if (photo != null) {
                          Get.find<PostController>().updateSelectImage(photo);
                          Get.find<PostController>()
                              .changeImageWidgetStatus(true);
                        }
                        Get.find<PostController>()
                            .changePostIndicatorState(false);
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
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
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          Get.find<PostController>().updateSelectImage(image);
                          Get.find<PostController>()
                              .changeImageWidgetStatus(true);
                        }
                        Get.find<PostController>()
                            .changePostIndicatorState(false);
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
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
                      print("click");
                      Get.find<PostController>().deleteImage();
                      Get.back();
                    },
                    child: Text("이미지 삭제")),
              ],
            ),
          ),
        ),
      ),
      GetBuilder<PostController>(builder: (_) {
        if (_.isShowIndicator) {
          return Container(
              color: Color(0x00000000),
              child: Center(
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
