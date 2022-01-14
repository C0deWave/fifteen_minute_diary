import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  late String title;
  @HiveField(1, defaultValue: "내용이 없습니다.")
  late String content;
  @HiveField(2)
  File? image;
  @HiveField(3)
  DateTime? writeDate;
  @HiveField(4, defaultValue: 0)
  late int duration;

  Post.fromJson(Map<String, dynamic> json) {
    // File temp = File("/${json['writeDate'].hashCode}");
    // temp.writeAsStringSync(json['image']);
    Post(
      title: json['title'] ?? "",
      content: json['content'] ?? "",
      image: null,
      writeDate: json['writeDate'] as DateTime?,
      duration: json['duration'] as int,
    );
  }

  Map<String, dynamic> toJson({required String imageUrl}) => {
        'title': title,
        'content': content,
        'image': imageUrl,
        'writeDate': writeDate,
        'duration': duration,
      };
}
