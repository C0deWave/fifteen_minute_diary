import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            child: const Text('카메라에서 선택'),
            onPressed: () => chooseCamera(),
          ),
          CupertinoActionSheetAction(
            child: const Text('앨범에서 선택'),
            onPressed: () => chooseAlbum(),
          )
        ],
      ),
    );
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
            ));
  }

  // 계정 정보 변경 AcrionSheet
  static void showUpdateUserdataActionSheet({
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
            ));
  }
}
