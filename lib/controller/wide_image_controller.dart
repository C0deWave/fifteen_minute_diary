import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WideImageController extends GetxController {
  int _indexNumber = 0;

  int getIndexNumber() => _indexNumber;
  void setIndexNumber(int indexnumber) {
    _indexNumber = indexnumber;
    update();
  }

  @override
  void onInit() {
    debugPrint('WideImageController 의존성 주입');
    super.onInit();
  }
}
