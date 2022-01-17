import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CardScrollController extends GetxController {
  final ScrollController _parentScrollController = ScrollController();
  final ScrollController _childScrollController = ScrollController();
  bool isTop = false;
  bool isNotBottom = true;

  ScrollController getParentScrollController() => _parentScrollController;
  ScrollController getChildScrollController() => _childScrollController;
  @override
  void onInit() {
    debugPrint('스크롤 컨트롤러 초기화');
    _childScrollController.addListener(_addChildScrollControllerListener);
    super.onInit();
  }

  _addChildScrollControllerListener() {
    // debugPrint('자식 스크롤 이동');
    if (_childScrollController.positions.first.pixels <=
            _childScrollController.positions.first.minScrollExtent &&
        _childScrollController.positions.first.outOfRange &&
        isTop) {
      _parentScrollController.animateTo(0,
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
    } else if (_childScrollController.positions.first.pixels <=
            _childScrollController.positions.first.minScrollExtent &&
        !_childScrollController.positions.first.outOfRange) {
      debugPrint('isTop = true');
      isTop = true;
      isNotBottom = true;
    } else if (_childScrollController.positions.first.pixels >
            _childScrollController.positions.first.minScrollExtent + 7 &&
        isNotBottom) {
      _parentScrollController.animateTo(
          _parentScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear);
      isTop = false;
      isNotBottom = false;
    } else {
      isTop = false;
    }
  }
}
