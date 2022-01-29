import 'package:get/get.dart';

enum TabbarState { diaryState, calendarState }

class TabbarController extends GetxController {
  TabbarState currentState = TabbarState.diaryState;
  int index = 0;

  void changeTabbarState(TabbarState state) {
    currentState = state;
    if (state == TabbarState.diaryState) {
      index = 0;
    } else {
      index = 1;
    }
    update();
  }
}
