import 'package:fifteen_minute_diary/main_peed_screen/component/main_peed_app_bar.dart';
import 'package:flutter/material.dart';
import 'component/mainPeedBody.dart';

class MainPeedScreen extends StatelessWidget {
  const MainPeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainPeedAppBar,
      body: MainPeedBody(),
      //TODO:: 사이드바 추후 개선하기
      drawer: Drawer(
        backgroundColor: Colors.green,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 80,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: SafeArea(child: Text('사이드바 입니다.')),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}
