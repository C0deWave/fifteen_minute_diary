import 'package:fifteen_minute_diary/controller/drawer_controller.dart';
import 'package:fifteen_minute_diary/custom_class/firebase_service.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/drawer_component/license_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DrawerNotLoginWidget extends StatelessWidget {
  const DrawerNotLoginWidget({Key? key}) : super(key: key);
  final GoogleSignInAccount? _currentUser = null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 65,
                    child: Image.asset(
                        'lib/assets/image/main_drawer_image/user.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                      child: Text("SNS연동을 통해\n소중한 추억을 저장하세요.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ))),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            Column(
              children: [
                SignInButton(
                  Buttons.AppleDark,
                  onPressed: () async {
                    Get.find<CustomDrawerController>().setIsShowIndicator(true);
                    try {
                      FirebaseService service = FirebaseService();
                      await service.signWithApple();
                    } finally {
                      Get.find<CustomDrawerController>()
                          .setIsShowIndicator(false);
                    }
                  },
                ),
                SignInButton(
                  Buttons.GoogleDark,
                  onPressed: () async {
                    Get.find<CustomDrawerController>().setIsShowIndicator(true);
                    try {
                      FirebaseService service = FirebaseService();
                      await service.signInwithGoogle();
                    } finally {
                      Get.find<CustomDrawerController>()
                          .setIsShowIndicator(false);
                    }
                  },
                ),
                const LicenseInfoWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
