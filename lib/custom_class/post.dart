import 'dart:io';
import 'package:fifteen_minute_diary/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

part 'post.g.dart';

@HiveType(typeId: 1)
class Post extends HiveObject {
  Post(
      {required this.title,
      required this.content,
      required this.image,
      required this.writeDate,
      required this.duration});
  @HiveField(0, defaultValue: "제목이 없습니다.")
  String title;
  @HiveField(1, defaultValue: "내용이 없습니다.")
  String content;
  @HiveField(2)
  File? image;
  @HiveField(3)
  DateTime? writeDate;
  @HiveField(4, defaultValue: 0)
  int duration;
}
