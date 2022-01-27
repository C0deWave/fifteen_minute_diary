import 'package:flutter/material.dart';

class HashTagItemWidget extends StatelessWidget {
  HashTagItemWidget({required this.title, Key? key}) : super(key: key);
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
    itemColorList.shuffle();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
              right: Radius.circular(12),
            ),
            border: Border.all(width: 2, color: itemColorList[0])),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: itemColorList[0]),
          ),
        ),
      ),
    );
  }
}
