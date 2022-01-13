import 'package:fifteen_minute_diary/controller/drawer_controller.dart';
import 'package:fifteen_minute_diary/custom_class/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class DrawerNotLoginWidget extends StatelessWidget {
  DrawerNotLoginWidget({Key? key}) : super(key: key);
  GoogleSignInAccount? _currentUser = null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 65,
                child:
                    Image.asset('lib/assets/image/main_drawer_image/user.png'),
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
          Column(
            children: [
              SignInButton(
                Buttons.AppleDark,
                onPressed: () {},
              ),
              SignInButton(
                Buttons.GoogleDark,
                onPressed: () async {
                  Get.find<CustomDrawerController>().setIsShowIndicator(true);
                  try {
                    FirebaseService service = new FirebaseService();
                    await service.signInwithGoogle();
                  } finally {
                    Get.find<CustomDrawerController>()
                        .setIsShowIndicator(false);
                  }
                },
              ),
              // SignInButton(
              //   Buttons.GitHub,
              //   onPressed: () async {
              //     Get.find<CustomDrawerController>().setIsShowIndicator(true);
              //     try {
              //       FirebaseService service = new FirebaseService();
              //       await service.signInwithGithub();
              //     } finally {
              //       Get.find<CustomDrawerController>()
              //           .setIsShowIndicator(false);
              //     }
              //   },
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
