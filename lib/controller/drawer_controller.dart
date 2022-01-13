import 'package:get/get_state_manager/get_state_manager.dart';

class CustomDrawerController extends GetxController {
  bool _isShowIndicator = false;

  bool getIsShowIndicator() => _isShowIndicator;

  void setIsShowIndicator(bool state) {
    _isShowIndicator = state;
    update();
  }
}
