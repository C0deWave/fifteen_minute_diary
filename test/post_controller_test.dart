import 'dart:io';
import 'dart:math';
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:fifteen_minute_diary/private_constant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;

void main() {
  group("post_controller: ", () {
    //---------------------------------------------------------------------------
    //테스트 사전 준비 설정
    setUpAll(() async {
      String? path;
      path = await setUpTestHive();
      Hive.registerAdapter(PostAdapter(path: path), internal: true);
      await Hive.openBox<Post>(k_PostBox);
    });

    //---------------------------------------------------------------------------
    //테스트 이후 소멸자
    tearDownAll(() async {
      await tearDownTestHive();
    });

    //--------------------------------------------------------------------------
    // 인디케이터의 동작을 확인합니다.
    // 만들면서 post_controller부분의_checkAndUpdateTodayWrite 부분 에러 발견
    test("indicator test", () {
      var postController = Get.put(PostController(), tag: "11");
      expect(false, postController.getIsShowIndicator());
      postController.changePostIndicatorState(true);
      expect(true, postController.getIsShowIndicator());
    });

    //--------------------------------------------------------------------------
    // 글이 추가가 되는지 확인합니다.
    // test("addPost method test", () async {
    //   // 일기를 써달라는 카드 존재
    //   var postController = Get.put(PostController(), tag: "12");
    //   expect(1, postController.getPostlist().length);

    //   //실제 일기
    //   postController.getTitleController().text = "testTitle";
    //   postController.getContextController().text = "testContent";
    //   postController.changeImageWidgetStatus(true);
    //   // postController.updateSelectImageList([
    //   //   XFile(File("lib/assets/image/default_writing_image/image1.jpg").path)
    //   // ]);
    //   await postController.addPostList(writeDuration: 10);
    //   expect(1, postController.getPostlist().length);

    //   postController.getTitleController().text = "testTitle2";
    //   await postController.addPostList(writeDuration: 10);
    //   expect(1, postController.getPostlist().length);
    // }
    // );
  });
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// HiveDatabase 초기화
Future<String> setUpTestHive() async {
  final tempDir = await getTempDir();
  Hive.init(tempDir.path);
  return tempDir.path;
}

// 종료시 hiveDatabase를 삭제합니다.
Future<void> tearDownTestHive() async {
  await Hive.deleteFromDisk();
}

// 임시 경로를 반환합니다.
final _random = Random();
String _tempPath =
    path.join(Directory.current.path, '.dart_tool', 'test', 'tmp');

Future<Directory> getTempDir() async {
  var name = _random.nextInt(pow(2, 32) as int);
  var dir = Directory(path.join(_tempPath, '${name}_tmp'));

  if (await dir.exists()) await dir.delete(recursive: true);

  await dir.create(recursive: true);
  return dir;
}
