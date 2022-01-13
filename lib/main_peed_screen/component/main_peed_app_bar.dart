import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

var mainPeedAppBar = AppBar(
    iconTheme: const IconThemeData(color: Colors.green),
    elevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: Colors.white,
    title: TimerBuilder.periodic(
      const Duration(seconds: 1),
      builder: (context) => AutoSizeText(
        formatDate(DateTime.now(),
            [yyyy, '년 ', m, '월 ', dd, "일 ", "", h, '시', nn, '분의 기록']),
        maxFontSize: 50,
        minFontSize: 3,
        maxLines: 1,
        style: const TextStyle(color: Colors.black),
      ),
    ));
