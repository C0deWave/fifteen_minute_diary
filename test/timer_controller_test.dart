// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'dart:math';
import 'package:fifteen_minute_diary/controller/timer_controller.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;

void main() {
  const String k_PostBox = 'postbox';
  group('timer_controller', () {
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

    //---------------------------------------------------------------------------
    //기본 값인 15분이 설정이 되어있는지 확인합니다.
    test('check timer init time', () {
      var timerController = Get.put(TimerController(), tag: "1");
      expect("15:00", timerController.getTimeText().value);
    });

    //--------------------------------------------------------------------------
    // 오늘 날짜가 잘 나오는지 확인합니다.
    test('check timer today Date', () {
      var timerController = Get.put(TimerController(), tag: "1");
      DateTime today = DateTime.now();
      expect(today.year, timerController.getWriteDate().year);
      expect(today.month, timerController.getWriteDate().month);
      expect(today.day, timerController.getWriteDate().day);
      expect(today.hour, timerController.getWriteDate().hour);
      expect(today.minute, timerController.getWriteDate().minute);
    });

    //--------------------------------------------------------------------------
    // 10초 뒤에 정지를 했을때 10초가 빠졌는지 확인합니다.
    test('check timer duration 3 second', () async {
      var timerController = Get.put(TimerController(), tag: "2");
      timerController.startTimer(
          finishFunction: () {}, remain1MinuteFunction: () {});
      await Future.delayed(const Duration(seconds: 3, milliseconds: 500), () {
        timerController.stopTimer();
      });
      await Future.delayed(const Duration(seconds: 1), () {});
      expect(3, timerController.getDuration());
      expect("14:57", timerController.getTimeText().value);
    });

    //--------------------------------------------------------------------------
    // 남은시간에서 타이머가 다시 시작되는지 확인합니다.
    test('check timer reload time', () async {
      var timerController = Get.put(TimerController(), tag: "3");
      timerController.startTimer(
          finishFunction: () {}, remain1MinuteFunction: () {});
      await Future.delayed(const Duration(seconds: 3, milliseconds: 500), () {
        timerController.stopTimer();
      });
      expect(3, timerController.getDuration());
      expect("14:57", timerController.getTimeText().value);
      timerController.startTimer(
          finishFunction: () {}, remain1MinuteFunction: () {});
      await Future.delayed(const Duration(seconds: 3, milliseconds: 500), () {
        timerController.stopTimer();
      });
      expect(6, timerController.getDuration());
      expect("14:54", timerController.getTimeText().value);
    });

    //--------------------------------------------------------------------------
    // sebtext가 잘 변화하는지 확인합니다.
    test('check timer subtext', () async {
      var timerController = Get.put(TimerController(), tag: "4");
      String notWrite = "15분간 일기에 집중해 주세요!";
      String writing = "남은 시간동안 수정할 수 있습니다.";
      String notHaveTime = "시간을 다 써서 더이상 수정할 수 없습니다.";
      expect(notWrite, timerController.getSubText().value);
      timerController.startTimer(
          finishFunction: () {}, remain1MinuteFunction: () {});
      await Future.delayed(const Duration(seconds: 3, milliseconds: 500), () {
        timerController.stopTimer();
      });
      expect(writing, timerController.getSubText().value);
      timerController.startTimer(
          finishFunction: () {}, remain1MinuteFunction: () {});
      await Future.delayed(
          const Duration(minutes: 14, seconds: 57, milliseconds: 500), () {
        timerController.stopTimer();
      });
      expect(notHaveTime, timerController.getSubText().value);
    }, timeout: const Timeout(Duration(minutes: 16)));
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
