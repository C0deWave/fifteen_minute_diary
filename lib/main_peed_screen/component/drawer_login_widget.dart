import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/custom_class/firebase_service.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
                  onPressed: () {
                    print('업로드 버튼 입력');
                    Map<String, dynamic> list =
                        Get.find<PostController>().getPostlistJson();
                    firebaseService.uploadDateToFireStore(list);
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
}


          // Text("${snapshot.data?.displayName}님 환영합니다."),


          // TextButton(
          //   onPressed: () {
          //     FirebaseAuth.instance.signOut();
          //   },
          //   child: Text("로그아웃"),
          // ),