import 'package:flutter/material.dart';

class HashTagCardItemWidget extends StatelessWidget {
  HashTagCardItemWidget({required this.width, Key? key}) : super(key: key);

  double width;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: width,
      height: width * 1.5,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://img.khan.co.kr/news/2021/08/15/l_2021081501002249400192111.webp',
                      ),
                      fit: BoxFit.cover)),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "나를 가장 힘들게 한 기능은 이거다 으어어어어",
                overflow: TextOverflow.clip,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
      ),
    );
  }
}
