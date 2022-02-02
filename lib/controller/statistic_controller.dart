import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaticController extends GetxController {
  // 변수 -----------------------------------------------------------------
  bool _showChartData = false;
  double _widgetHeigth = 180;
  String _title = '월간 통계';
  String _subTitle = '이번달은 얼마나 일기를 썼을까?';

  // 함수 ------------------------------------------------------------------
  getShowChartData() => _showChartData;
  getWidgetHeight() => _widgetHeigth;
  String getTitleText() => _title;
  String getSubTitleText() => _subTitle;

  getMonthlyStatistic({
    required int totalDay,
    required int dailyDay,
    required int totalTime,
    required int dailyTime,
  }) {
    return Column(
      children: [
        Center(
          child: Text(
            "$dailyDay일 / $totalDay일",
            style: const TextStyle(
                color: Color(0xff0f4a3c),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            "$dailyTime분 / $totalTime분",
            style: const TextStyle(
                color: Color(0xff0f4a3c),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  setShowChartData() {
    _showChartData = !_showChartData;
    updateWidgetHeight();
    updateTitle();
    updateSubTitle();
    update();
  }

  updateSubTitle() {
    if (_showChartData) {
      _subTitle = '요일별 일기쓴 시간을 보여줍니다.';
    } else {
      _subTitle = '이번달은 얼마나 일기를 썼을까?';
    }
  }

  updateTitle() {
    if (_showChartData) {
      _title = '주차별 통계';
    } else {
      _title = '월간 통계';
    }
  }

  updateWidgetHeight() {
    if (_showChartData) {
      _widgetHeigth = 280.0;
    } else {
      _widgetHeigth = 180.0;
    }
  }

  // 주차별 차트 데이터를 반환합니다.
  BarChartData getMainBarData({required List<double> bardata}) {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
          margin: 10,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '월';
              case 1:
                return '화';
              case 2:
                return '수';
              case 3:
                return '목';
              case 4:
                return '금';
              case 5:
                return '토';
              case 6:
                return '일';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(bardata),
      gridData: FlGridData(show: false),
    );
  }

  // 요일 데이터
  List<BarChartGroupData> showingGroups(List<double> data) =>
      List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, data[0],
                barColor: Colors.green.shade800, isTouched: false);
          case 1:
            return makeGroupData(1, data[1]);
          case 2:
            return makeGroupData(2, data[2]);
          case 3:
            return makeGroupData(3, data[3]);
          case 4:
            return makeGroupData(4, data[4]);
          case 5:
            return makeGroupData(5, data[5]);
          case 6:
            return makeGroupData(6, data[6]);
          default:
            return throw Error();
        }
      });

  // 하나의 바 데이터 입니다.
  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 20,
  }) {
    const Color barBackgroundColor = Color(0xff72d8bf);
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          colors: [barColor],
          width: width,
          borderSide: const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 15,
            colors: [barBackgroundColor],
          ),
        ),
      ],
    );
  }
}
