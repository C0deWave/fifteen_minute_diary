import 'dart:io';
import 'package:fifteen_minute_diary/controller/wide_image_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/wide_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

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
            child: StaggeredItem(imagelist: imagelist, indexNumber: 1),
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
            child: StaggeredItem(imagelist: imagelist, indexNumber: 1),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: StaggeredItem(imagelist: imagelist, indexNumber: 2),
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
            child: StaggeredItem(imagelist: imagelist, indexNumber: 1),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: StaggeredItem(imagelist: imagelist, indexNumber: 2),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: StaggeredItem(imagelist: imagelist, indexNumber: 3),
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
            child: StaggeredItem(imagelist: imagelist, indexNumber: 1),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: StaggeredItem(imagelist: imagelist, indexNumber: 2),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: StaggeredItem(imagelist: imagelist, indexNumber: 3),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: StaggeredItem(imagelist: imagelist, indexNumber: 4),
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
            child: StaggeredItem(imagelist: imagelist, indexNumber: 1),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: StaggeredItem(imagelist: imagelist, indexNumber: 2),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: StaggeredItem(imagelist: imagelist, indexNumber: 3),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: StaggeredItem(imagelist: imagelist, indexNumber: 4),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: StaggeredItem(imagelist: imagelist, indexNumber: 5),
          ),
        ],
      );
    }
    return Container();
  }
}

class StaggeredItem extends StatelessWidget {
  StaggeredItem({
    required this.indexNumber,
    required this.imagelist,
    Key? key,
  }) : super(key: key);

  final List<File>? imagelist;
  int indexNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<WideImageController>().setIndexNumber(indexNumber);
        Get.to(WideImageWidget(
          imagelist: imagelist,
          indexNumber: indexNumber,
        ));
      },
      child: Hero(
        tag: indexNumber.toString(),
        child: Container(
            color: Colors.red,
            child: Image.file(
              imagelist![indexNumber - 1],
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
