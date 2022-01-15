import 'package:fifteen_minute_diary/controller/drawer_controller.dart';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/custom_class/firebase_service.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DrawerLoginWidget extends StatelessWidget {
  DrawerLoginWidget({Key? key, required this.snapshot}) : super(key: key);

  AsyncSnapshot<User?> snapshot;

  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService = FirebaseService();
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 85,
                  foregroundImage: NetworkImage("${snapshot.data?.photoURL}"),
                ),
                const SizedBox(height: 20),
                Text(
                  "${snapshot.data?.displayName}님 환영합니다.",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MaterialButton(
                  onPressed: () async {
                    print('업로드 버튼 입력');
                    _show1MinuteRemainToast();
                    Get.find<CustomDrawerController>().setIsShowIndicator(true);
                    Map<String, dynamic> list =
                        await Get.find<PostController>().getPostlistJson();
                    firebaseService.uploadDateToFireStore(list);

                    Get.find<CustomDrawerController>()
                        .setIsShowIndicator(false);
                  },
                  child: Text('데이터 업로드'),
                ),
                MaterialButton(
                  onPressed: () {
                    print('버튼 입력');
                  },
                  child: Text('데이터 다운로드'),
                )
              ],
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text("로그아웃"),
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


          // Text("${snapshot.data?.displayName}님 환영합니다."),


          // TextButton(
          //   onPressed: () {
          //     FirebaseAuth.instance.signOut();
          //   },
          //   child: Text("로그아웃"),
          // ),