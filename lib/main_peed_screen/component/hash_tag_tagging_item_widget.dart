import 'package:fifteen_minute_diary/controller/tag_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HashTagTaggingItemWidget extends StatelessWidget {
  HashTagTaggingItemWidget(
      {required this.title, required this.isChecked, Key? key})
      : super(key: key);

  final bool isChecked;
  final String title;
  List<Color> itemColorList = [
    Colors.purple,
    Colors.blueGrey,
    Colors.blue,
    Colors.green,
    Colors.yellow.shade700,
    Colors.orange,
    Colors.redAccent,
    Colors.pink.shade500
  ];

  @override
  Widget build(BuildContext context) {
    if (title == '') {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: GestureDetector(
        onTap: () {
          debugPrint('태그클릭');
          Get.find<TagController>().setTagCheckStatus(title);
        },
        child: Container(
          decoration: BoxDecoration(
              color: isChecked
                  ? itemColorList[title.hashCode % itemColorList.length]
                  : Colors.white,
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
                  color: isChecked
                      ? Colors.white
                      : itemColorList[title.hashCode % itemColorList.length]),
            ),
          ),
        ),
      ),
    );
  }
}
