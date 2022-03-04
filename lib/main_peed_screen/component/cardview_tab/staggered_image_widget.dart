import 'dart:io';
import 'package:fifteen_minute_diary/controller/wide_image_controller.dart';
import 'package:fifteen_minute_diary/main_peed_screen/component/cardview_tab/wide_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class StaggeredImageView extends StatelessWidget {
  const StaggeredImageView({Key? key, required this.imagelist, this.dateTime})
      : super(key: key);

  final List<File>? imagelist;
  final DateTime? dateTime;
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
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 1,
              dateTime: dateTime ?? DateTime.now(),
            ),
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
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 1,
              dateTime: dateTime ?? DateTime.now(),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 2,
              dateTime: dateTime ?? DateTime.now(),
            ),
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
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 1,
              dateTime: dateTime ?? DateTime.now(),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 2,
              dateTime: dateTime ?? DateTime.now(),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 3,
              dateTime: dateTime ?? DateTime.now(),
            ),
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
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 1,
              dateTime: dateTime ?? DateTime.now(),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 2,
              dateTime: dateTime ?? DateTime.now(),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 3,
              dateTime: dateTime ?? DateTime.now(),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 4,
              dateTime: dateTime ?? DateTime.now(),
            ),
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
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 1,
              dateTime: dateTime ?? DateTime.now(),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 2,
              dateTime: dateTime ?? DateTime.now(),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 3,
              dateTime: dateTime ?? DateTime.now(),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 4,
              dateTime: dateTime ?? DateTime.now(),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: StaggeredItem(
              imagelist: imagelist,
              indexNumber: 5,
              dateTime: dateTime ?? DateTime.now(),
            ),
          ),
        ],
      );
    }
    return Container();
  }
}

class StaggeredItem extends StatelessWidget {
  const StaggeredItem({
    required this.indexNumber,
    required this.imagelist,
    required this.dateTime,
    Key? key,
  }) : super(key: key);

  final List<File>? imagelist;
  final int indexNumber;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<WideImageController>().setIndexNumber(indexNumber);
        Get.to(WideImageWidget(
          imagelist: imagelist,
          indexNumber: indexNumber,
          dateTime: dateTime,
        ));
      },
      child: Hero(
        tag: dateTime.toString() + indexNumber.toString(),
        child: Image.file(
          imagelist![indexNumber - 1],
          fit: BoxFit.cover,
          cacheHeight: 200,
          cacheWidth: 200,
          key: Key("image" + indexNumber.toString()),
        ),
      ),
    );
  }
}
