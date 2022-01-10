import 'package:fifteen_minute_diary/main_peed_screen/component/drawer_login_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/drawer_not_login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.data == null) {
          return DrawerNotLoginWidget();
        } else {
          return DrawerLoginWidget(
            snapshot: snapshot,
          );
        }
      },
    );
  }
}
