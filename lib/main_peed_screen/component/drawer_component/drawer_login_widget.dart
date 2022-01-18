import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/controller/drawer_controller.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/controller/timer_controller.dart';
import 'package:fifteen_minute_diary/custom_class/firebase_service.dart';
import 'package:fifteen_minute_diary/custom_class/hive_database.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/drawer_component/drawer_list_tile.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/drawer_component/license_info_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/drawer_component/underline_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DrawerLoginWidget extends StatelessWidget {
  const DrawerLoginWidget({Key? key, required this.snapshot}) : super(key: key);

  final AsyncSnapshot<User?> snapshot;

  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService = FirebaseService();
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                  child: CircleAvatar(
                    radius: 43,
                    foregroundImage: (snapshot.data?.photoURL?.isEmpty != null)
                        ? NetworkImage("${snapshot.data?.photoURL}")
                        : Image.asset(
                                "lib/assets/image/main_drawer_image/user.png")
                            .image,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "${snapshot.data?.displayName}님 환영합니다.",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DrawerListTile(
                    icon: const Icon(Icons.question_mark),
                    text: '일기주제 추천',
                    clickFunction: () {
                      debugPrint('일기주제 추천');
                    },
                  ),
                  const UnderlineWidget(),
                  DrawerListTile(
                    icon: const Icon(Icons.upload),
                    text: '데이터 업로드',
                    clickFunction: () async {
                      debugPrint('업로드 버튼 입력');
                      _show1MinuteRemainToast();
                      Get.find<CustomDrawerController>()
                          .setIsShowIndicator(true);
                      Map<String, dynamic> list =
                          await Get.find<PostController>().getPostlistJson();
                      firebaseService.uploadDateToFireStore(list);
                      Get.find<CustomDrawerController>()
                          .setIsShowIndicator(false);
                    },
                  ),
                  const UnderlineWidget(),
                  DrawerListTile(
                    icon: const Icon(Icons.download),
                    text: '데이터 다운로드',
                    clickFunction: () async {
                      Get.find<CustomDrawerController>()
                          .setIsShowIndicator(true);
                      await HiveDataBase().clearHiveDatabase();
                      Map<String, dynamic>? list =
                          await firebaseService.downloadDataToFireStore();
                      if (list != null) {
                        Get.find<PostController>().setPostlist(list,
                            (duration) {
                          Get.find<TimerController>().updateTimeFromLastPost(
                              k_TimerTotalDuration - duration);
                        });
                      } else {
                        debugPrint('백업 데이터가 없습니다.');
                      }
                      Get.find<CustomDrawerController>()
                          .setIsShowIndicator(false);
                    },
                  ),
                  const UnderlineWidget(),
                  DrawerListTile(
                    icon: const Icon(Icons.settings),
                    text: '계정정보 변경',
                    clickFunction: () {
                      debugPrint('계정정보 변경');
                    },
                  ),
                  const UnderlineWidget(),
                  DrawerListTile(
                    icon: const Icon(Icons.report),
                    text: '버그 신고',
                    clickFunction: () {
                      debugPrint('버그신고');
                      Get.find<CustomDrawerController>().mailToDeveloper();
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text("로그아웃"),
                  ),
                  const LicenseInfoWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _show1MinuteRemainToast() {
    debugPrint('show Toast Message');
    Fluttertoast.showToast(
        msg: "데이터를 업로드 합니다.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade800,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
