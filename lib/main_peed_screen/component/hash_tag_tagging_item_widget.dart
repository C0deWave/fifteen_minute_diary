import 'package:flutter/material.dart';

class HashTagTaggingItemWidget extends StatelessWidget {
  HashTagTaggingItemWidget({required this.title, Key? key}) : super(key: key);
  final String title;
  List<Color> itemColorList = [
    Colors.purple,
    Colors.blueGrey,
    Colors.blue,
    Colors.green,
    Colors.yellow.shade700,
    Colors.orange,
    Colors.redAccent,
  ];

  @override
  Widget build(BuildContext context) {
    if (title == '') {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
              right: Radius.circular(12),
            ),
            border: Border.all(
                width: 2,
                color: itemColorList[title.hashCode % itemColorList.length])),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            title.length > 10 ? title.substring(0, 10) + '...' : title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: itemColorList[title.hashCode % itemColorList.length]),
          ),
        ),
      ),
    );
  }
}
