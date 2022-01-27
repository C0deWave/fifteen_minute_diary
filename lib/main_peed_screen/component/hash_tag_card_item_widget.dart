import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:flutter/material.dart';

class HashTagCardItemWidget extends StatelessWidget {
  HashTagCardItemWidget({required this.width, required this.postdata, Key? key})
      : super(key: key);

  Post postdata;
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                      image: FileImage(
                        postdata.imagelist![0],
                      ),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                postdata.title,
                overflow: TextOverflow.clip,
                maxLines: 2,
                style: const TextStyle(
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
