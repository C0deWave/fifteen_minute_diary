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
                        ? "${snapshot.data?.displayName}??? ???????????????."
                        : "?????????????????? ????????? ????????? ?????????.",
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
                    text: '???????????? ??????',
                    clickFunction: () {
                      // Get.dialog(RecommendDiaryTopicWidget());
                      RecommendDiaryTopic().showDailyTopic(context,
                          okFunction: () async {
                        Get.back();
                        await Future.delayed(const Duration(milliseconds: 500));
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
                          debugPrint('?????? ????????? ????????????.');
                        }
                      });
                      debugPrint('???????????? ??????');
                    },
                  ),
                  const UnderlineWidget(),
                  DrawerListTile(
                    icon: const Icon(Icons.upload),
                    text: '????????? ?????????',
                    clickFunction: () async {
                      DialogList.showBackUpStartDiaryAlert(
                        context: context,
                        yesAction: () async {
                          Get.back();
                          debugPrint('????????? ?????? ??????');
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
                    text: '????????? ????????????',
                    clickFunction: () async {
                      DialogList.showBackUpDownloadDiaryAlert(
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
                            debugPrint('?????? ???????????? ????????????.');
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
                    text: '?????? ??????',
                    clickFunction: () {
                      debugPrint('?????? ??????');
                      ActionSheetList.showUpdateUserdataActionSheet(
                          context: context,
                          selectRepresentativeImageFunction: () {
                            Get.back();
                            DialogList.showWhereSelectImage(context: context);
                          },
                          updateUserNameFunction: () {
                            Get.back();
                            DialogList.showChangeWhatName(context: context);
                          },
                          leaveAccountFunction: () {
                            Get.back();
                            DialogList.showLeaveAccountDialog(context: context);
                          });
                    },
                  ),
                  const UnderlineWidget(),
                  DrawerListTile(
                    icon: const Icon(Icons.report),
                    text: '?????? ??????',
                    clickFunction: () {
                      DialogList.showReportMailAlert(
                          context: context,
                          yesAction: () {
                            debugPrint('????????????');
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
                    child: const Text("????????????"),
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
