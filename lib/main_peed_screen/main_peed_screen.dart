import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'component/mainPeedBody.dart';

class MainPeedScreen extends StatelessWidget {
  const MainPeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        elevation: 0,
        backgroundColor: Colors.white12,
        //TODO autosizetext 적용하기
        title: Container(
          child: const AutoSizeText(
            "YYYY년 MM월 DD일 HH시 mm분",
            maxFontSize: 50,
            minFontSize: 3,
            maxLines: 1,
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ),
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
