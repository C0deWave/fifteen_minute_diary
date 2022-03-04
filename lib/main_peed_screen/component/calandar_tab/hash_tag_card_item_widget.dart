import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/controller/tabbar_controller.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HashTagCardItemWidget extends StatelessWidget {
  const HashTagCardItemWidget(
      {required this.width, required this.postdata, Key? key})
      : super(key: key);

  final Post postdata;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<TabbarController>().changeTabbarState(TabbarState.diaryState);
        Future.delayed(const Duration(milliseconds: 500))
            .then((value) => Get.find<PostController>().jumpThisPost(postdata));
        debugPrint('일기 선택');
      },
      child: SizedBox(
        width: width,
        height: width * 1.5,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    image: DecorationImage(
                        image: FileImage(
                          postdata.imagelist![0],
                        ),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  postdata.title,
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
