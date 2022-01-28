import 'package:cupertino_tabbar/cupertino_tabbar.dart';
import 'package:fifteen_minute_diary/controller/tabbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabbarWidget extends StatelessWidget {
  // int index = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GetBuilder<TabbarController>(
        builder: (tabbarController) => Container(
          color: Colors.white,
          child: CupertinoTabBar(
            Colors.white12,
            Color.fromARGB(255, 48, 119, 51),
            [
              Text(
                "내 일기 목록",
                style: TextStyle(
                  color:
                      tabbarController.index == 0 ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "둘러보기",
                style: TextStyle(
                  color:
                      tabbarController.index == 1 ? Colors.white : Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            () {
              return tabbarController.index;
            },
            (data) {
              if (data == 0) {
                tabbarController.changeTabbarState(TabbarState.diaryState);
              } else {
                tabbarController.changeTabbarState(TabbarState.calendarState);
              }
              tabbarController.index = data;
            },
            allowExpand: true,
            useShadow: false,
            innerVerticalPadding: 10,
            outerHorizontalPadding: 30,
          ),
        ),
      ),
    );
  }
}
