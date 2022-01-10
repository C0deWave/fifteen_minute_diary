import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerLoginWidget extends StatelessWidget {
  DrawerLoginWidget({Key? key, required this.snapshot}) : super(key: key);

  AsyncSnapshot<User?> snapshot;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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