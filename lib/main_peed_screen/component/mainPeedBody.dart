import 'package:fifteen_minute_diary/main_peed_screen/component/tabbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'DiaryCardViewWidget.dart';
import 'TimerWidget.dart';

class MainPeedBody extends StatelessWidget {
  const MainPeedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: CustomScrollView(
          shrinkWrap: true,
          // child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          slivers: [
            SliverStickyHeader(
              header: Container(),
              //타이머
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TimerWidget(
                      callback: () {
                        print("click timer");
                      },
                    ),
                  ),
                  childCount: 1,
                ),
              ),
            ),
            //일기 리스트
            SliverStickyHeader(
              header: TabbarWidget(),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => DiaryCardViewWidget(),
                  //TODO : 일기 개수 반영하기
                  childCount: 10,
                ),
              ),
            )
          ],
        ),
      )
    ]);
  }
}
