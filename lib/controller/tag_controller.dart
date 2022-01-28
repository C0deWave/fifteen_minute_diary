import 'package:fifteen_minute_diary/custom_class/tag.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class TagController extends GetxController {
  @override
  void onInit() {
    debugPrint("TagController 생성");
    super.onInit();
  }

  @override
  void onClose() {
    debugPrint("TagController 삭제");
    super.onClose();
  }

  final List<Tag> _taglist = [];

  List<Tag> getTaglist() => _taglist;

  // 새로운 태그 리스트를 만듭니다.
  // 중복되는 값은 패스한다.
  // 기존 태그에서 겹치지 않는 태그는 삭제한다.
  // 최종적으로 새로운 태그에서 겹치지 않는 태그는 추가한다.
  void setTaglist(List<String> newTaglist) {
    List<String>? tempNewTaglist = [];
    tempNewTaglist.addAll(newTaglist);
    debugPrint('태그를 새로 생성합니다.');
    if (tempNewTaglist.isEmpty) {
      _taglist.clear();
      return;
    }
    // 기존의 태그 리스트를 순회
    if (_taglist != []) {
      for (var item in _taglist) {
        if (tempNewTaglist.contains(item.title)) {
          //새로운 태그 리스트가 해당 값이 있을경우
          // 중복이기 새로운 값에서 제거
          tempNewTaglist.remove(item.title);
        } else {
          // 기존의 태그 리스트가 해당값이 없을 경우
          // 태그 제거
          _taglist.remove(item);
        }
      }
    }
    // 새로운 태그에서 남은 것은 기존의 태그 뒤에 추가해준다.
    // newTaglist.map((e) => _taglist.add(Tag(title: e, isChecked: false)));
    for (var item in tempNewTaglist) {
      _taglist.add(Tag(title: item, isChecked: false));
    }

    // isChecked가 된것을 앞으로 정렬해 준다.
    sortedTaglist();
    print('Taglist: ' + _taglist.toString());
    update();
  }

  // 체크가 되있는 것이 앞으로 가게 설정합니다.
  // 리스트를 정렬합니다.
  void sortedTaglist() {
    _taglist.sort(((a, b) {
      if (a.isChecked == b.isChecked) {
        return a.title.compareTo(b.title);
      } else {
        if (a.isChecked == true) {
          return -1;
        } else {
          return 1;
        }
      }
    }));
  }

  // 체크 상태를 변화 합니다.
  void setTagCheckStatus(String title) {
    for (var e in _taglist) {
      if (e.title == title) {
        debugPrint('상태 변화');
        e.isChecked = !e.isChecked;
        break;
      }
    }
    sortedTaglist();
    update();
  }
}
