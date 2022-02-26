import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;

class ActionSheetList {
  // 이미지 추가 액션 시트
  static void showAddImageSheet(
      {required BuildContext context,
      required Function chooseCamera,
      required Function chooseAlbum}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('사진 선택'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('카메라에서 쵤영'),
            onPressed: () => chooseCamera(),
          ),
          CupertinoActionSheetAction(
            child: const Text('앨범에서 선택'),
            onPressed: () => chooseAlbum(),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: const Text(
            '취소',
          ),
          onPressed: () => Get.back(),
        ),
      ),
    );
  }

  // 일기 삭제 Action Sheet
  static void showDeleteDiarySheet(
      {required BuildContext context, required Function deleteAction}) {
    ActionSheetList.deleteDiaryActionSheet(
        context: context,
        deleteFunction: () {
          deleteAction();
        });
  }

  // 이미지 삭제 또는 대표이미지 지정 ActionSheet
  static void selectImageDeleteOrRepresentImage({
    required BuildContext context,
    required Function selectRepresentImageFunction,
    required Function deleteImageFunction,
  }) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              title: const Text('사진 선택'),
              // message: const Text('사진은 최대 5장까지 가능합니다.'),
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(
                  child: const Text('대표 이미지로 지정'),
                  onPressed: () => selectRepresentImageFunction(),
                ),
                CupertinoActionSheetAction(
                  child: const Text(
                    '이미지 삭제',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () => deleteImageFunction(),
                )
              ],
              cancelButton: CupertinoActionSheetAction(
                isDestructiveAction: true,
                child: const Text(
                  '취소',
                ),
                onPressed: () => Get.back(),
              ),
            ));
  }

  // 일기 삭제 액션 시트
  static void deleteDiaryActionSheet(
      {required BuildContext context, required Function deleteFunction}) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(
                  child: const Text(
                    '일기 삭제',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () => deleteFunction(),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                isDestructiveAction: true,
                child: const Text(
                  '취소',
                ),
                onPressed: () => Get.back(),
              ),
            ));
  }

  // ----------------------------------------------------------------
  // ----------------------------------------------------------------
  // 계정 정보 변경 플랫폼 확인
  static void showUpdateUserdataActionSheet({
    required BuildContext context,
    required Function selectRepresentativeImageFunction,
    required Function updateUserNameFunction,
    required Function leaveAccountFunction,
  }) {
    foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS
        ? showIosUpdateUserdataActionSheet(
            context: context,
            selectRepresentativeImageFunction:
                selectRepresentativeImageFunction,
            updateUserNameFunction: updateUserNameFunction,
            leaveAccountFunction: leaveAccountFunction,
          )
        : showAndroidUpdateUserdataActionSheet(
            context: context,
            selectRepresentativeImageFunction:
                selectRepresentativeImageFunction,
            updateUserNameFunction: updateUserNameFunction,
            leaveAccountFunction: leaveAccountFunction,
          );
  }

  // 계정 정보 변경 AcrionSheet
  static void showIosUpdateUserdataActionSheet({
    required BuildContext context,
    required Function selectRepresentativeImageFunction,
    required Function updateUserNameFunction,
    required Function leaveAccountFunction,
  }) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(
                  child: const Text(
                    '대표이미지 선택',
                  ),
                  onPressed: () => selectRepresentativeImageFunction(),
                ),
                CupertinoActionSheetAction(
                  child: const Text(
                    '이름 변경',
                  ),
                  onPressed: () => updateUserNameFunction(),
                ),
                CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  child: const Text(
                    '계정 탈퇴',
                  ),
                  onPressed: () => leaveAccountFunction(),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                isDestructiveAction: true,
                child: const Text(
                  '취소',
                ),
                onPressed: () => Get.back(),
              ),
            ));
  }

  // 안드로이드 계정정보 확인 Action Sheet
  static void showAndroidUpdateUserdataActionSheet({
    required BuildContext context,
    required Function selectRepresentativeImageFunction,
    required Function updateUserNameFunction,
    required Function leaveAccountFunction,
  }) {
    showModalBottomSheet<dynamic>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return Wrap(
            children: [
              GestureDetector(
                onTap: () => selectRepresentativeImageFunction(),
                child: const ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    '대표이미지 선택',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => updateUserNameFunction(),
                child: const ListTile(
                  leading: Icon(Icons.edit),
                  title: Text(
                    '이름 변경',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => leaveAccountFunction(),
                child: const ListTile(
                  leading: Icon(Icons.delete_forever),
                  title: Text(
                    '계정 탈퇴',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          );
        });
  }
  // ----------------------------------------------------------------
  // ----------------------------------------------------------------
}
