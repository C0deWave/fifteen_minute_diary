import 'dart:io';
import 'dart:math';
import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/custom_class/hive_database.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class PostController extends GetxController {
  //--------------------------------------------------------------------
  // 변수
  //쓴 일기의 내용을 추출하는데 사용합니다.
  final _titleController = TextEditingController();
  final _contextController = TextEditingController();
  // 이미지를 선택했는지 확인하는 용도로 사용
  bool _isUsedImage = false;
  //인디케이터 확인용 코드
  bool _isShowIndicator = false;
  // 선택한 이미지 파일
  XFile? _selectedImage;
  // 포커스 전환을 하는데 사용합니다.
  final _titleFocusController = FocusNode();
  final _contextFocusController = FocusNode();
  //Post게시글 리스트
  final List<Post> _postlist = [];
  //Post list Hive 저장소
  late HiveDataBase _postBox;
  //로그 확인용 태그
  final String _tag = 'post_controller: ';

  //--------------------------------------------------------------------
  // 함수
  // 초기화 함수
  @override
  void onInit() {
    _postBox = HiveDataBase();
    debugPrint(_tag + 'postBox controller 주입');
    _getPostlistFromPostbox();
    _sortPostlist();
    _checkTodayWrite();
    super.onInit();
  }

  //GetMethod
  TextEditingController getTitleController() => _titleController;
  TextEditingController getContextController() => _contextController;
  FocusNode getTitleFocusController() => _titleFocusController;
  FocusNode getContextFocusController() => _contextFocusController;
  List<Post> getPostlist() => _postlist;
  XFile? getSelectedImage() => _selectedImage;
  bool getIsUsedImage() => _isUsedImage;
  bool getIsShowIndicator() => _isShowIndicator;

  // Hive저장소에 있는 데이터를 리스트에 넣습니다.
  void _getPostlistFromPostbox() {
    for (var i = 0; i < _postBox.getLength(); i++) {
      var temp = _postBox.getAtPost(i);
      if (temp != null) {
        _postlist.add(temp);
      }
    }
  }

  //Postlist의 내용을 시간순으로 정렬합니다.
  void _sortPostlist() {
    _postlist.sort((Post temp1, Post temp2) {
      return temp1.writeDate != null
          ? temp1.writeDate!.compareTo(temp2.writeDate ?? DateTime.now())
          : k_SortRight;
    });
  }

  // 현재 적은 내용을 저장합니다.
  void addPostList({required int writeDuration}) async {
    DateTime writeDate = DateTime.now();
    if (_checkTitleAndContentIsWrite()) {
      Post temp = await _makePostBasedCurrentWrite(writeDate, writeDuration);
      String postIndexKey = _makePostIndexKey(writeDate);
      _postlist.removeLast();
      _postlist.add(temp);
      await _postBox.pushPostToHive(postIndexKey, temp);
      debugPrint(
          _tag + "postBox크기 ${_postBox.getLength()}\n키값: " + postIndexKey);
      resetWriteState();
      update();
    }
  }

  // 현재 날짜를 기준으로 키값을 만듭니다.
  String _makePostIndexKey(DateTime writeDate) {
    return (writeDate.year.toString() +
        _twoDigits(writeDate.month) +
        _twoDigits(writeDate.day));
  }

  // 현재 쓴 내용을 객체로 변환합니다.
  Future<Post> _makePostBasedCurrentWrite(
      DateTime writeDate, int duration) async {
    int tempImage = Random(DateTime.now().hashCode).nextInt(3) + 1;
    print('image/$tempImage.jpg');
    return Post(
        title: _titleController.text,
        content: _contextController.text,
        image: _selectedImage != null
            ? File(_selectedImage!.path)
            : await _getImageFileFromAssets(
                'lib/assets/image/default_writing_image/image$tempImage.jpg'),
        writeDate: writeDate,
        duration: duration);
  }

  //에셋에서 이미지를 불러옵니다.
  Future<File> _getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);

    final file = File('${(await getTemporaryDirectory()).path}/test.jpg');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  // 내용이 적혀 있는지 확인합니다.
  bool _checkTitleAndContentIsWrite() {
    return _titleController.text.isNotEmpty &&
        _contextController.text.isNotEmpty;
  }

  // 인디케이터 상태를 변환합니다.
  // 이미지 로딩을 기다릴때 사용합니다.
  void changePostIndicatorState(bool state) {
    _isShowIndicator = state;
    update();
  }

  // 글을 초기 상태로 되돌립니다.
  //TODO추후 제거예정 고려
  void resetWriteState() {
    _titleController.clear();
    _contextController.clear();
    _isUsedImage = false;
    _selectedImage = null;
    _checkTodayWrite();
    update();
  }

  // 지정된 이미지를 삭제합니다.
  void deleteImage() {
    _selectedImage = null;
    _isUsedImage = false;
    update();
  }

  //이미지 위젯 보여줄지 말지 상태 업데이트
  void changeImageWidgetStatus(bool status) {
    _isUsedImage = status;
    debugPrint(_tag + "이미지 상태 업데이트");
    update();
  }

  // 선택한 이미지로 변경
  void updateSelectImage(XFile? imageData) {
    if (imageData != null) {
      _selectedImage = imageData;
      debugPrint(_tag + "이미지 데이터를 업로드 합니다.");
    }
  }

  // 재목에서 내용으로 포커스 전환
  void completeTitleWrite() {
    debugPrint(_tag + "data");
    _contextFocusController.requestFocus();
  }

  // 숫자 포맷을 두자리로 한다.
  String _twoDigits(int n) => n >= 10 ? "$n" : "0$n";

  // 오늘 적은 일기가 있는지 확인합니다.
  void _checkTodayWrite() {
    DateTime? lastPostDate;
    if (_postlist.isEmpty) {
      lastPostDate = DateTime(1997);
    } else {
      lastPostDate = _postlist.last.writeDate;
    }
    DateTime todayDate = DateTime.now();
    if (!_checkDateIsSame(lastPostDate!, todayDate)) {
      _postlist.add(k_NotWritePost);
    } else {
      _updateWriteScreenContent();
    }
  }

  // 오늘 적은일기가 있다면 컨트롤러의 내용을 업데이트 합니다.
  void _updateWriteScreenContent() {
    var todayWrite = _postlist.last;
    debugPrint(_tag + "오늘 글을 적었습니다..");
    _titleController.text = todayWrite.title;
    _contextController.text = todayWrite.content;
    _selectedImage = XFile(todayWrite.image!.path);
    _isUsedImage = true;
  }

  bool _checkDateIsSame(DateTime date1, DateTime date2) {
    return (date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day);
  }
}
