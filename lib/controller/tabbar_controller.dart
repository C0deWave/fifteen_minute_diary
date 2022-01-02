import 'package:get/get.dart';

enum TabbarState { diaryState, calendarState }

class TabbarController extends GetxController {
  TabbarState currentState = TabbarState.diaryState;

  void changeTabbarState(TabbarState state) {
    currentState = state;
    update();
  }
}
