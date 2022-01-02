import 'package:cupertino_tabbar/cupertino_tabbar.dart';
import 'package:fifteen_minute_diary/controller/tabbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabbarWidget extends StatefulWidget {
  @override
  State<TabbarWidget> createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CupertinoTabBar(
        Colors.white12,
        Colors.green.shade700,
        [
          Text(
            "내 일기 목록",
            style: TextStyle(
              color: index == 0 ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "캘린더",
            style: TextStyle(
              color: index == 1 ? Colors.white : Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        () {
          return index;
        },
        (data) {
          if (data == 0) {
            Get.find<TabbarController>()
                .changeTabbarState(TabbarState.diaryState);
          } else {
            Get.find<TabbarController>()
                .changeTabbarState(TabbarState.calendarState);
          }
          setState(() {
            index = data;
          });
        },
        allowExpand: true,
        useShadow: false,
        innerVerticalPadding: 10,
        outerHorizontalPadding: 30,
      ),
    );
  }
}
