import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

var MainPeedAppBar = AppBar(
    iconTheme: IconThemeData(color: Colors.green),
    elevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: Colors.white,
    title: TimerBuilder.periodic(
      const Duration(seconds: 1),
      builder: (context) => AutoSizeText(
        formatDate(DateTime.now(),
            [yyyy, '-', mm, '-', dd, "  ", "", HH, ':', nn, '']),
        maxFontSize: 50,
        minFontSize: 3,
        maxLines: 1,
        style: TextStyle(color: Colors.black),
      ),
    ));
