import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
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
  //     debugPrint(_tag + openstack.toString());
  //     _postBox = Hive.box(k_PostBox);
  //     openstack++;
  //   } else {
  //     debugPrint(_tag + "이미 데이터베이스가 열려 있습니다.");
  //     openstack++;
  //   }
  // }

  // stack를 확인해서 데이터베이스를 닫는다.
  // void closeDatabase() {
  //   if (openstack > 0) {
  //     openstack--;
  //   } else {
  //     _postBox.close();
  //   }
  // }

  // Post객체를 해당 키값에 맞춰 담는다.
  Future<bool> pushPostToHive(String key, Post value) async {
    try {
      var tempPost = _postBox.get(key);
      if (tempPost != null) {
        _postBox.delete(key);
        _postBox.put(key, value);
      } else {
        _postBox.put(key, value);
      }
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

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
}
