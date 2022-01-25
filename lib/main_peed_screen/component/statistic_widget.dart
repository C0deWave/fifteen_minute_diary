import 'package:fifteen_minute_diary/controller/statistic_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({Key? key}) : super(key: key);

  final Duration animDuration = const Duration(milliseconds: 350);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaticController>(
      builder: (controller) => Container(
        color: Colors.white,
        height: controller.getWidgetHeight(),
        child: Card(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: const Color.fromARGB(255, 129, 229, 172),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      controller.getTitleText(),
                      style: const TextStyle(
                          color: Color(0xff0f4a3c),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      controller.getSubTitleText(),
                      style: const TextStyle(
                          color: Color(0xff379982),
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: controller.getShowChartData()
                          ? BarChart(
                              controller.mainBarData(),
                              swapAnimationDuration: animDuration,
                            )
                          : Column(
                              children: const [
                                Center(
                                  child: Text(
                                    "15일 / 31일",
                                    style: TextStyle(
                                        color: Color(0xff0f4a3c),
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "19분 / 450분",
                                    style: TextStyle(
                                        color: Color(0xff0f4a3c),
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
