import 'package:fifteen_minute_diary/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryCardViewWidget extends StatelessWidget {
  const DiaryCardViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width,
        height: Get.height / 3,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3,
          color: Colors.orangeAccent.shade400,
          child: Row(
            //TODO 반전 포맷도 하나 만들기
            children: ImageFormat,
          ),
        ));
  }
}

var ImageFormat = [
  Flexible(
      child: Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
        image: DecorationImage(
            image: NetworkImage(caturl), fit: BoxFit.fitHeight)),
  )),
  Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2021년 12월 15일",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text("2시 15분"),
              ],
            ),
            Center(
              child: Text("ddd\nddd\nffasfa\ndsadsa"),
            ),
            Text("12분동안 작성...")
          ],
        ),
      ))
];
