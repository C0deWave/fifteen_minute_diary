import 'package:fifteen_minute_diary/controller/drawer_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/drawer_component/drawer_login_widget.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/drawer_component/drawer_not_login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CustomDrawerController());
    return Stack(
      children: [
        StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.data == null) {
              return const DrawerNotLoginWidget();
            } else {
              return DrawerLoginWidget(snapshot: snapshot);
            }
          },
        ),
        GetBuilder<CustomDrawerController>(builder: (controller) {
          return controller.getIsShowIndicator()
              ? const Drawer(
                  backgroundColor: Color.fromARGB(115, 0, 0, 0),
                  elevation: 0,
                  child: Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : Container();
        })
      ],
    );
  }
}
