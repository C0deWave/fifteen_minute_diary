import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredImageView extends StatelessWidget {
  StaggeredImageView({Key? key, required this.imagelist}) : super(key: key);

  List<File>? imagelist;
  @override
  Widget build(BuildContext context) {
    if (imagelist != null && imagelist!.length == 1) {
      return StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        axisDirection: AxisDirection.down,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: Container(
                color: Colors.green,
                child: Image.file(
                  imagelist![0],
                  fit: BoxFit.cover,
                )),
          ),
        ],
      );
    } else if (imagelist != null && imagelist!.length == 2) {
      return StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        axisDirection: AxisDirection.down,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: Container(
                color: Colors.pink,
                child: Image.file(
                  imagelist![0],
                  fit: BoxFit.cover,
                )),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: Container(
                color: Colors.red,
                child: Image.file(
                  imagelist![1],
                  fit: BoxFit.cover,
                )),
          ),
        ],
      );
    } else if (imagelist != null && imagelist!.length == 3) {
      return StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        axisDirection: AxisDirection.down,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: Container(
                color: Colors.red,
                child: Image.file(
                  imagelist![0],
                  fit: BoxFit.cover,
                )),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: Container(
                color: Colors.red,
                child: Image.file(
                  imagelist![1],
                  fit: BoxFit.cover,
                )),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: Container(
                color: Colors.red,
                child: Image.file(
                  imagelist![2],
                  fit: BoxFit.cover,
                )),
          ),
        ],
      );
    } else if (imagelist != null && imagelist!.length == 4) {
      return StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        axisDirection: AxisDirection.up,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: Container(
                color: Colors.red,
                child: Image.file(
                  imagelist![0],
                  fit: BoxFit.cover,
                )),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: Container(
                color: Colors.red,
                child: Image.file(
                  imagelist![1],
                  fit: BoxFit.cover,
                )),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
                color: Colors.red,
                child: Image.file(
                  imagelist![2],
                  fit: BoxFit.cover,
                )),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
                color: Colors.red,
                child: Image.file(
                  imagelist![3],
                  fit: BoxFit.cover,
                )),
          ),
        ],
      );
    } else if (imagelist != null && imagelist!.length == 5) {
      return StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        axisDirection: AxisDirection.down,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: Container(
                color: Colors.red,
                child: Image.file(
                  imagelist![0],
                  fit: BoxFit.cover,
                )),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
                color: Colors.red,
                child: Image.file(
                  imagelist![1],
                  fit: BoxFit.cover,
                )),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
                color: Colors.red,
                child: Image.file(
                  imagelist![2],
                  fit: BoxFit.cover,
                )),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
                color: Colors.red,
                child: Image.file(
                  imagelist![3],
                  fit: BoxFit.cover,
                )),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
                color: Colors.red,
                child: Image.file(
                  imagelist![4],
                  fit: BoxFit.cover,
                )),
          ),
        ],
      );
    }
    return Container();
  }
}
