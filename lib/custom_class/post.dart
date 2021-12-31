import 'dart:io';

class Post {
  Post({required this.title, required this.content, required this.image}) {}
  String title;
  String content;
  File image;
}
