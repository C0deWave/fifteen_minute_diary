import 'package:flutter/material.dart';

// var mainPeedAppBar =
class MainPeedAppBar extends StatelessWidget {
  const MainPeedAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 60, 4),
              child: Icon(
                Icons.menu,
                color: Colors.green.shade600,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: Text(
              "${today.year}년 ${today.month}월 ${today.day}일",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.green.shade900),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: Text(
              "15분 일기",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.green.shade600),
            ),
          ),
        ],
      ),
    );
  }
}
