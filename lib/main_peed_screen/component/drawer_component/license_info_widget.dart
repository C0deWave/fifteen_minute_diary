import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LicenseInfoWidget extends StatelessWidget {
  const LicenseInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Get.dialog(LicenseInfoDialog());
        },
        child: const Text(
          '라이센스정보',
          style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
              decoration: TextDecoration.underline),
        ));
  }
}

class LicenseInfoDialog extends StatelessWidget {
  const LicenseInfoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Center(
                  child: Text(
                '라이센스 정보',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  // fontWeight: FontWeight.normal
                ),
              )),
            ),
            Container(
              width: 200,
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            Center(
                child: Text(
              'Drawer Default Image',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(height: 3),
            Center(
              child: Text(
                'Icons made by Freepik from \nwww.flaticon.com',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              'unDraw image licence',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  '''Copyright 2021 Katerina Limpitsouni

All images, assets and vectors published on unDraw can be used for free. You can use them for noncommercial and commercial purposes. You do not need to ask permission from or provide credit to the creator or unDraw.
''',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
