import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CameraAndImagePicker {
  // 카메라에서 이미지를 선택합니다.
  static Future<File?> selectFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    XFile? selectedImage = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 200,
        maxHeight: 200,
        imageQuality: 95);
    if (selectedImage == null) {
      return null;
    } else {
      return File(selectedImage.path);
    }
  }

  //앨범에서 이미지 한장을 선택합니다.
  static selectFromAlbum() async {
    final ImagePicker _picker = ImagePicker();
    XFile? selectedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 200,
        maxWidth: 200,
        imageQuality: 95);
    if (selectedImage == null) {
      return null;
    } else {
      return File(selectedImage.path);
    }
  }
}
