import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

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
  String title = 'empty';
  @HiveField(1, defaultValue: "내용이 없습니다.")
  String content = 'empty';
  @HiveField(2)
  File? image;
  @HiveField(3)
  DateTime? writeDate;
  @HiveField(4, defaultValue: 0)
  int duration = 0;

  static Future<Post> fromJson(Map<String, dynamic> json) async {
    var responseData = await http.get(Uri.parse(json['image']));
    Directory tempDir = await getTemporaryDirectory();
    var uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    File file = File('${tempDir.path}/${json["writeDate"]}');
    file.writeAsBytesSync(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return Post(
      title: json['title'],
      content: json['content'],
      image: file,
      writeDate: (json['writeDate'] as Timestamp).toDate(),
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
