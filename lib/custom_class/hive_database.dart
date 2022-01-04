import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:hive/hive.dart';

// 여러군대에서 같은 키값으로 DB를 열수 없어서 싱글톤의 형태로 만듬
class HiveDataBase {
  static final HiveDataBase _database = HiveDataBase._interval();
  late Box<Post> _postBox;
  int openstack = 0;
  factory HiveDataBase() {
    return _database;
  }
  HiveDataBase._interval() {
    _postBox = Hive.box(k_PostBox);
  }

  void openDatabase() {
    if (_postBox.isOpen == false) {
      if (k_DebugMode) {
        // ignore: avoid_print
        print(openstack);
      }
      _postBox = Hive.box(k_PostBox);
      openstack++;
    } else {
      openstack++;
    }
  }

  void closeDatabase() {
    if (openstack > 0) {
      openstack--;
    } else {
      _postBox.close();
    }
  }

  bool pushPostToHive(String key, Post value) {
    _postBox.put(key, value);
    return true;
  }

  int getLength() {
    return _postBox.length;
  }

  Post? getAtPost(int index) {
    return _postBox.getAt(index);
  }

  Post? getPost(String key) {
    return _postBox.get(key);
  }
}
