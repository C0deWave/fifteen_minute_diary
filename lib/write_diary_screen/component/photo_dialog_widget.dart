import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/post_controller.dart';

class PhotoDialogWidget extends StatelessWidget {
  const PhotoDialogWidget({
    Key? key,
    required ImagePicker picker,
  })  : _picker = picker,
        super(key: key);

  final ImagePicker _picker;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    print("star");
                    final XFile? photo =
                        await _picker.pickImage(source: ImageSource.camera);
                    Get.find<PostController>().updateSelectImage(photo);
                    Get.find<PostController>().changeImageWidgetStatus(true);
                    Get.back();
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    Get.find<PostController>().updateSelectImage(image);
                    Get.find<PostController>().changeImageWidgetStatus(true);
                    Get.back();
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Icon(
                          Icons.add_photo_alternate_rounded,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
