// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/custom_class/hive_database.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;

void main() {
  const String k_PostBox = 'postbox';

  group("HiveDatabase: ", () {
    String? path;
    late HiveDataBase hiveDataBase;

    //---------------------------------------------------------------------------
    // 테스트 전 사전준비
    setUpAll(() async {
      debugPrint("HiveDatabase 테스트 준비중");
      path = await setUpTestHive();
      Hive.registerAdapter(PostAdapter(path: path), internal: true);
      await Hive.openBox<Post>(k_PostBox);
      hiveDataBase = HiveDataBase();
    });

    //---------------------------------------------------------------------------
    //테스트 이후 소멸자
    tearDownAll(() async {
      debugPrint("tearDown을 실행합니다.");
      await tearDownTestHive();
    });

    //---------------------------------------------------------------------------
    // database open
    test("database open test", () async {
      // 작동 테스트
      expect(true, hiveDataBase.isOpenBox());
      // debugPrint(' - database open test [O]');
    });

    //---------------------------------------------------------------------------
    // push and getPost test
    test("hive getAtPost method test", () async {
      int length = hiveDataBase.getLength();

      for (var i = 0; i < length; i++) {
        Post? temp = hiveDataBase.getAtPost(i);
        expect(true, temp != null);
      }
    });

    //---------------------------------------------------------------------------
    test("push and get from key test", () async {
      String hiveIndexTestKey = "20200101";

      // push 테스트
      expect(true, await hiveDataBase.pushPostToHive(k_NotWritePost));
      // get 테스트
      expect(k_NotWritePost, hiveDataBase.getPost(hiveIndexTestKey));
    });

    //---------------------------------------------------------------------------
    // post length test
    test("database length check test", () async {
      String hiveIndexTestKey = "20200102";
      int length = hiveDataBase.getLength();

      // push 테스트
      expect(
          true,
          await hiveDataBase.pushPostToHive(Post(
              title: hiveIndexTestKey,
              content: "content",
              imagelist: null,
              writeDate: null,
              duration: 0,
              hashtags: [])));
      expect(length + 1, hiveDataBase.getLength());
    });
    //---------------------------------------------------------------------------
  });
}

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
