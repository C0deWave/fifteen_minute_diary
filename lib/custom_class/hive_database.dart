import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:fifteen_minute_diary/private_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

// 여러군대에서 같은 키값으로 DB를 열수 없어서 싱글톤의 형태로 만듬
class HiveDataBase {
  //------------------------------------------------------------
  // 변수
  static final HiveDataBase _database = HiveDataBase._interval();
  final String _tag = "HiveDatabase: ";
  late Box<Post> _postBox;
  // int openstack = 0;

  //---------------------------------------------------------------
  // 함수
  // Singleton을 위한 팩토리 메서드
  factory HiveDataBase() {
    return _database;
  }

  // init역할을 한다.
  HiveDataBase._interval() {
    debugPrint(_tag + '데이터베이스가 열렸습니다.');
    _postBox = Hive.box(k_PostBox);
  }

  //open상태인지 확인한다.
  bool isOpenBox() => (_postBox.isOpen);

  // 데이터베이스가 닫혀있는 경우 데이터 베이스를 연다.
  // void openDatabase() {
  //   if (_postBox.isOpen == false) {
  //     _postBox = Hive.box(k_PostBox);
  //   } else {
  //     debugPrint(_tag + "이미 데이터베이스가 열려 있습니다.");
  //   }
  // }

  // Post객체를 해당 키값에 맞춰 담는다.
  Future<bool> pushPostToHive(Post postdata) async {
    String key = _makePostIndexKey(postdata.writeDate ?? DateTime.now());
    // openDatabase();
    try {
      var tempPost = _postBox.get(key);
      if (tempPost != null) {
        await _postBox.delete(key);
        await _postBox.put(key, postdata);
      } else {
        await _postBox.put(key, postdata);
      }
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  // 포스트 객체에 맞는 키값을 만들어 낸다.
  String _makePostIndexKey(DateTime writeDate) {
    return (writeDate.year.toString() +
        _twoDigits(writeDate.month) +
        _twoDigits(writeDate.day));
  }

  // 숫자 포맷을 두자리로 한다.
  String _twoDigits(int n) => n >= 10 ? "$n" : "0$n";

  // PostBox의 크기를 확인한다.
  int getLength() {
    return _postBox.length;
  }

  // 인덱스 순서대로 Post객체를 불러온다.
  Post? getAtPost(int index) {
    return _postBox.getAt(index);
  }

  // 해당 키값에 맞는 객체를 불러온다.
  Post? getPost(String key) {
    return _postBox.get(key);
  }

  // 데이터베이스를 초기화 합니다.
  Future<bool> clearHiveDatabase() async {
    debugPrint('데이터베이스를 초기화 합니다.');
    if (_postBox.isOpen) {
      await Hive.deleteBoxFromDisk(k_PostBox);
      await Hive.deleteFromDisk();
      await _postBox.close();
      _postBox = await Hive.openBox(k_PostBox);
    }
    return true;
  }
}
