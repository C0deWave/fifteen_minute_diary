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
      required this.imagelist,
      required this.writeDate,
      required this.duration,
      required this.hashtags});

  @HiveField(0, defaultValue: "제목이 없습니다.")
  String title = 'empty';
  @HiveField(1, defaultValue: "내용이 없습니다.")
  String content = 'empty';
  @HiveField(2)
  List<File>? imagelist;
  @HiveField(3)
  DateTime? writeDate;
  @HiveField(4, defaultValue: 0)
  int duration = 0;
  @HiveField(5)
  List<String> hashtags;

  static Future<Post> fromJson(Map<String, dynamic> json) async {
    List<File> imagelist = [];
    List<dynamic> urlList = json['image'] as List<dynamic>;
    Directory tempDir = await getTemporaryDirectory();
    for (var i = 0; i < urlList.length; i++) {
      var responseData = await http.get(Uri.parse(urlList[i]));
      var uint8list = responseData.bodyBytes;
      var buffer = uint8list.buffer;
      ByteData byteData = ByteData.view(buffer);
      File file = File('${tempDir.path}/${json["writeDate"]}$i');
      file.writeAsBytesSync(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      imagelist.add(file);
    }
    return Post(
        title: json['title'],
        content: json['content'],
        imagelist: imagelist,
        writeDate: (json['writeDate'] as Timestamp).toDate(),
        duration: json['duration'] as int,
        hashtags: json['hashtags'] as List<String>);
  }

  Map<String, dynamic> toJson({required List<String> imageUrl}) => {
        'title': title,
        'content': content,
        'image': imageUrl,
        'writeDate': writeDate,
        'duration': duration,
        'hashtags': hashtags,
      };
}
