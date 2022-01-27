import 'package:fifteen_minute_diary/main_peed_screen/component/hash_tag_card_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HashTagWidget extends StatelessWidget {
  const HashTagWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, i) => Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    HashTagCardItemWidget(width: Get.width * 0.47),
                    HashTagCardItemWidget(width: Get.width * 0.47),
                    HashTagCardItemWidget(width: Get.width * 0.47),
                    HashTagCardItemWidget(width: Get.width * 0.47),
                    HashTagCardItemWidget(width: Get.width * 0.47),
                    HashTagCardItemWidget(width: Get.width * 0.47),
                    HashTagCardItemWidget(width: Get.width * 0.47),
                    HashTagCardItemWidget(width: Get.width * 0.47),
                  ],
                )),
            childCount: 1));
  }
}
