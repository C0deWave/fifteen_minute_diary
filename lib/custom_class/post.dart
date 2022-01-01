import 'dart:io';

class Post {
  Post(
      {required this.title,
      required this.content,
      required this.image,
      required this.writeDate,
      required this.duration}) {}
  String title;
  String content;
  File image;
  DateTime writeDate;
  int duration;
}
