import 'package:fifteen_minute_diary/controller/calendar_controller.dart';
import 'package:fifteen_minute_diary/custom_class/tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HashTagTaggingItemWidget extends StatelessWidget {
  HashTagTaggingItemWidget({required this.tag, Key? key}) : super(key: key);

  final Tag tag;
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
    if (tag.title == '') {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: GestureDetector(
        onTap: () {
          debugPrint('태그클릭');
          Get.find<CalendarController>().updateTagStatus(tag);
        },
        child: Container(
          decoration: BoxDecoration(
              color: tag.isChecked
                  ? itemColorList[tag.title.hashCode % itemColorList.length]
                  : Colors.white,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
                right: Radius.circular(12),
              ),
              border: Border.all(
                  width: 2,
                  color: itemColorList[
                      tag.title.hashCode % itemColorList.length])),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              tag.title.length > 10
                  ? tag.title.substring(0, 10) + '...'
                  : tag.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: tag.isChecked
                      ? Colors.white
                      : itemColorList[
                          tag.title.hashCode % itemColorList.length]),
            ),
          ),
        ),
      ),
    );
  }
}
