import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/controller/calendar_controller.dart';
import 'package:fifteen_minute_diary/controller/drawer_controller.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/controller/timer_controller.dart';
import 'package:fifteen_minute_diary/custom_class/action_sheet_list.dart';
import 'package:fifteen_minute_diary/custom_class/dialog_list.dart';
import 'package:fifteen_minute_diary/custom_class/firebase_service.dart';
import 'package:fifteen_minute_diary/custom_class/hive_database.dart';
import 'package:fifteen_minute_diary/custom_class/toast_list.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/drawer_component/drawer_list_tile.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/drawer_component/license_info_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/drawer_component/recommend_diary_topic_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/drawer_component/underline_widget.dart';
import 'package:fifteen_minute_diary/write_diary_screen/write_diary_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerLoginWidget extends StatelessWidget {
  const DrawerLoginWidget({Key? key, required this.snapshot}) : super(key: key);

  final AsyncSnapshot<User?> snapshot;

  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService = FirebaseService();
    var timerController = Get.find<TimerController>();
    var postController = Get.find<PostController>();
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
                            "lib/assets/image/main_drawer_image/user.png",
                            cacheHeight: 200,
                            cacheWidth: 200,
                          ).image,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    snapshot.data?.displayName != null
                        ? "${snapshot.data?.displayName}님 환영합니다."
                        : "계정정보에서 이름을 지정해 주세요.",
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
                      // Get.dialog(RecommendDiaryTopicWidget());
                      RecommendDiaryTopic().showDailyTopic(context,
                          okFunction: () async {
                        Get.back();
                        await Future.delayed(Duration(milliseconds: 500));
                        if (timerController.haveTime()) {
                          timerController.startTimer(
                              finishFunction: () {
                                postController
                                    .addPostList(
                                        writeDuration:
                                            timerController.getDuration())
                                    .then((value) =>
                                        Get.find<CalendarController>()
                                            .updateCalenderPostlist());
                                timerController.stopTimer();
                                Get.back();
                              },
                              remain1MinuteFunction:
                                  ToastList.show1MinuteRemainToast);
                          Get.to(() => const WriteDiaryScreen());
                          debugPrint("click timer");
                        } else {
                          ToastList.showNotHaveRemainTimeToast();
                          debugPrint('남은 시간이 없습니다.');
                        }
                      });
                      debugPrint('일기주제 추천');
                    },
                  ),
                  const UnderlineWidget(),
                  DrawerListTile(
                    icon: const Icon(Icons.upload),
                    text: '데이터 업로드',
                    clickFunction: () async {
                      DialogList.showIosBackUpStartDiaryAlert(
                        context: context,
                        yesAction: () async {
                          Get.back();
                          debugPrint('업로드 버튼 입력');
                          ToastList.showDataUploadToast();
                          Get.find<CustomDrawerController>()
                              .setIsShowIndicator(true);
                          Map<String, dynamic> list =
                              await Get.find<PostController>().getPostlistJson(
                                  firebaseService.getUserUid());
                          firebaseService.uploadDateToFireStore(list);
                          Get.find<CustomDrawerController>()
                              .setIsShowIndicator(false);
                        },
                        noAction: () {
                          Get.back();
                        },
                      );
                    },
                  ),
                  const UnderlineWidget(),
                  DrawerListTile(
                    icon: const Icon(Icons.download),
                    text: '데이터 다운로드',
                    clickFunction: () async {
                      DialogList.showIosBackUpDownloadDiaryAlert(
                        context: context,
                        yesAction: () async {
                          Get.back();
                          Get.find<CustomDrawerController>()
                              .setIsShowIndicator(true);
                          await HiveDataBase().clearHiveDatabase();
                          Map<String, dynamic>? list =
                              await firebaseService.downloadDataToFireStore();
                          if (list != null) {
                            await Get.find<PostController>().setPostlist(list,
                                (duration) {
                              Get.find<TimerController>()
                                  .updateTimeFromLastPost(
                                      k_TimerTotalDuration - duration);
                              Get.find<CalendarController>()
                                  .updateCalenderPostlist();
                            });
                          } else {
                            debugPrint('백업 데이터가 없습니다.');
                          }
                          Get.find<CustomDrawerController>()
                              .setIsShowIndicator(false);
                        },
                        noAction: () {
                          Get.back();
                        },
                      );
                    },
                  ),
                  const UnderlineWidget(),
                  DrawerListTile(
                    icon: const Icon(Icons.settings),
                    text: '계정 정보',
                    clickFunction: () {
                      debugPrint('계정 정보');
                      ActionSheetList.showUpdateUserdataActionSheet(
                          context: context,
                          selectRepresentativeImageFunction: () {
                            Get.back();
                            DialogList.showIosWhereSelectImage(context);
                          },
                          updateUserNameFunction: () {
                            Get.back();
                            DialogList.showIosChangeWhatName(context);
                          },
                          leaveAccountFunction: () {
                            Get.back();
                            DialogList.showIosLeaveAccountDialog(context);
                          });
                    },
                  ),
                  const UnderlineWidget(),
                  DrawerListTile(
                    icon: const Icon(Icons.report),
                    text: '의견 제시',
                    clickFunction: () {
                      DialogList.showIosReportMailAlert(
                          context: context,
                          yesAction: () {
                            debugPrint('버그신고');
                            Get.back();
                            Get.find<CustomDrawerController>()
                                .mailToDeveloper();
                          },
                          noAction: () {
                            Get.back();
                          });
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
                    onPressed: () async {
                      FirebaseAuth.instance.signOut();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString(k_OAuthProvider, k_ProviderNull);
                    },
                    child: const Text("로그아웃"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      LicenseInfoWidget(),
                      SizedBox(width: 10),
                      MaterialButton(
                        splashColor: Color.fromARGB(0, 255, 255, 255),
                        highlightColor: Color.fromARGB(0, 255, 255, 255),
                        onPressed: null,
                        child: Text(
                          'version: 1.0.0',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
