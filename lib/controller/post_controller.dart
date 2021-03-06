import 'dart:io';
import 'dart:math';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:fifteen_minute_diary/constant.dart';
import 'package:fifteen_minute_diary/custom_class/hive_database.dart';
import 'package:fifteen_minute_diary/custom_class/post.dart';
import 'package:fifteen_minute_diary/custom_class/toast_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
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
  List<XFile>? _selectedImageList;
  // 포커스 전환을 하는데 사용합니다.
  final _titleFocusController = FocusNode();
  final _contextFocusController = FocusNode();
  //Post게시글 리스트
  final List<Post> _postlist = [];
  //Post list Hive 저장소
  late HiveDataBase _postBox;
  //로그 확인용 태그
  final String _tag = 'post_controller: ';
  final _carouselController = CarouselController();

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
  List<XFile>? getSelectedImageList() => _selectedImageList;
  bool getIsUsedImage() => _isUsedImage;
  bool getIsShowIndicator() => _isShowIndicator;
  CarouselController getCarouselConteoller() => _carouselController;

  void jumpThisPost(Post postdata) {
    for (var i = 0; i < _postlist.length; i++) {
      if (checkDateIsSame(postdata.writeDate, _postlist[i].writeDate)) {
        _carouselController.animateToPage(_postlist.length - 1 - i,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuint);
      }
    }
  }

  //제목을 변경합니다.
  void updateTitleText(String title) {
    _titleController.text = title;
  }

  //조커 카드를 제외한 Json화한 게시글 리스트를 받습니다.
  Future<Map<String, dynamic>> getPostlistJson(String userUid) async {
    var postList = getPostlist();
    if (postList.last == k_NotWritePost) {
      debugPrint('조커카드가 있습니다. => 제거');
      postList.removeLast();
    }
    List<Map<String, dynamic>> jsondata = [];
    for (var i = 0; i < postList.length; i++) {
      List<String> imageUrl =
          await _uploadImageToFireStorage(postList[i].imagelist, userUid);
      jsondata.add(postList[i].toJson(imageUrl: imageUrl));
    }
    return {"data": jsondata};
  }

  // 이미지를 파이어베이스에 업로드 합니다.
  Future<List<String>> _uploadImageToFireStorage(
      List<File>? imageList, String userUid) async {
    if (imageList == null) {
      return [""];
    } else {
      String userUid = FirebaseAuth.instance.currentUser!.uid;
      List<String> urlList = [];
      for (var i = 0; i < imageList.length; i++) {
        var dataRef = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(userUid)
            .child('${userUid}_${imageList[i].hashCode}.png');
        await dataRef.putFile(imageList[i]);
        urlList.add(await dataRef.getDownloadURL());
      }
      return urlList;
    }
  }

  // Hive저장소에 있는 데이터를 리스트에 넣습니다.
  void _getPostlistFromPostbox() {
    debugPrint(_tag + "저장소에서 글을 불러옵니다.");
    _postlist.clear();
    for (var i = 0; i < _postBox.getLength(); i++) {
      var temp = _postBox.getAtPost(i);
      if (temp != null) {
        _postlist.add(temp);
      }
    }
    debugPrint(
        "postlist: ${_postlist.length} postBox: ${_postBox.getLength()}");
    update();
  }

  //Postlist의 내용을 시간순으로 정렬합니다.
  void _sortPostlist() {
    debugPrint('시간순으로 정렬을 시도합니다.');
    _postlist.sort((Post temp1, Post temp2) {
      return temp1.writeDate != null && temp2.writeDate != null
          ? temp1.writeDate!.compareTo(temp2.writeDate!)
          : k_SortRight;
    });
  }

  // 현재 적은 내용을 저장합니다.
  Future<bool> addPostList({required int writeDuration}) async {
    DateTime writeDate = DateTime.now();
    if (_checkTitleAndContentIsWrite() || _checkTodayWrite()) {
      Post temp = await _makePostBasedCurrentWrite(writeDate, writeDuration);
      await _postBox.pushPostToHive(temp);
      _getPostlistFromPostbox();
      _checkTodayWrite();
      update();
      return true;
    } else {
      resetWriteState();
      return false;
    }
  }

  // 현재 쓴 내용을 객체로 반환합니다.
  Future<Post> _makePostBasedCurrentWrite(
      DateTime writeDate, int duration) async {
    int tempImage =
        Random(DateTime.now().hashCode).nextInt(k_StandardImageLength) + 1;
    debugPrint(_tag + '파일명 image/$tempImage.jpg');
    List<String> hashtags = extractHashTags(_contextController.text);
    return Post(
        title: _titleController.text,
        content: _contextController.text,
        imagelist: _isUsedImage == true
            ? _selectedImageList!.map((e) => File(e.path)).toList()
            : [
                await _getImageFileFromAssets(
                    'lib/assets/image/default_writing_image/image$tempImage.jpg')
              ],
        writeDate: writeDate,
        duration: duration,
        hashtags: hashtags);
  }

  //에셋에서 임시 이미지를 불러옵니다.
  Future<File> _getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);
    debugPrint('임시파일 생성');
    final file =
        File('${(await getTemporaryDirectory()).path}/${path.hashCode}.jpg');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  // 내용이 적혀 있는지 확인합니다.
  bool _checkTitleAndContentIsWrite() {
    if (_titleController.text.isNotEmpty &&
        _contextController.text.isNotEmpty) {
      return true;
    } else {
      debugPrint("글을 적지 않았습니다.");
      return false;
    }
  }

  // 인디케이터 상태를 변환합니다.
  // 이미지 로딩을 기다릴때 사용합니다.
  void changePostIndicatorState(bool state) {
    _isShowIndicator = state;
    update();
  }

  // 글을 초기 상태로 되돌립니다.
  void resetWriteState() {
    _titleController.clear();
    _contextController.clear();
    _isUsedImage = false;
    _selectedImageList = null;
    update();
  }

  // 지정된 이미지를 삭제합니다.
  void deleteImage() {
    _selectedImageList = null;
    _isUsedImage = false;
    update();
  }

  //이미지 위젯 보여줄지 말지 상태 업데이트
  void changeImageWidgetStatus(bool status) {
    _isUsedImage = status;
    debugPrint(_tag + "이미지 상태 업데이트");
    update();
  }

  // 특정 이미지 추가
  void addSelectImage(XFile selectedImage) {
    if (_selectedImageList != null) {
      if (_selectedImageList!.length >= 5) {
        debugPrint('5개 이상 이미지 선택 불가');
        ToastList.showLimitFiveImageToast();
        return;
      }
      _selectedImageList?.add(selectedImage);
    } else {
      _selectedImageList = [selectedImage];
    }
    update();
  }

  // 특정 위치의 인덱스를 제거 합니다.
  void removeImageOfIndex(int index) {
    _selectedImageList?.removeAt(index);
    update();
  }

  // 특정 위치의 인덱스를 1번으로 해서 대표이미지화 합니다.
  void setRepresentativeImage(int index) {
    XFile temp = _selectedImageList![index];
    _selectedImageList?.removeAt(index);
    _selectedImageList?.insert(0, temp);
    update();
  }

  // 재목에서 내용으로 포커스 전환
  void completeTitleWrite() {
    debugPrint(_tag + "data");
    _contextFocusController.requestFocus();
  }

  // 오늘 적은 일기가 있는지 확인합니다.
  bool _checkTodayWrite() {
    DateTime? lastPostDate =
        _postlist.isEmpty ? DateTime(1997) : _postlist.last.writeDate;
    DateTime todayDate = DateTime.now();
    if (!checkDateIsSame(lastPostDate, todayDate)) {
      if (!_postlist.contains(k_NotWritePost)) {
        _postlist.add(k_NotWritePost);
      }
      resetWriteState();
      return false;
    } else {
      _updateWriteScreenContent();
      return true;
    }
  }

  // 오늘 적은일기가 있다면 컨트롤러의 내용을 업데이트 합니다.
  void _updateWriteScreenContent() {
    var todayWrite = _postlist.last;
    debugPrint(_tag + "오늘 글을 적었습니다..");
    _titleController.text = todayWrite.title;
    _contextController.text = todayWrite.content;
    _selectedImageList =
        todayWrite.imagelist!.map((e) => XFile(e.path)).toList();
    _isUsedImage = true;
  }

  // 년월일이 같은지 확인합니다.
  bool checkDateIsSame(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) {
      return false;
    }
    return (date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day);
  }

  // 파이어베이스에서 Postlist를 불러와서 저장합니다.
  Future<void> setPostlist(
      Map<String, dynamic> list, Function(int) addCallback) async {
    List<dynamic> data = list['data'];
    _postlist.clear();
    for (var item in data) {
      await _addPostFutureData(item, addCallback);
    }
    bool isTodayWrite = _checkTodayWrite();
    if (!isTodayWrite) {
      addCallback(0);
    }
    update();
  }

  // 비동기로 Post객체를 추가합니다.
  Future<void> _addPostFutureData(item, Function(int) addCallback) async {
    Post postdata = await Post.fromJson(item);
    _postlist.add(postdata);
    _sortPostlist();
    if (_postlist.last.writeDate != null &&
        checkDateIsSame(DateTime.now(), _postlist.last.writeDate)) {
      addCallback(_postlist.last.duration);
      _updateWriteScreenContent();
    }
    update();
    HiveDataBase().pushPostToHive(postdata);
  }

  // 특정일기를 리스트와 내부 데이터베이스에서 삭제합니다.
  void deletePostByWriteDate(DateTime? dateTime) async {
    HiveDataBase hiveDataBase = HiveDataBase();
    late Post tempData;
    if (dateTime == null) {
      debugPrint('시간값이 없습니다.');
      return;
    }
    for (var i = 0; i < _postlist.length; i++) {
      if (_postlist[i].writeDate != null &&
          checkDateIsSame(dateTime, _postlist[i].writeDate!)) {
        tempData = _postlist[i];
        _postlist.removeAt(i);
        break;
      }
    }
    await hiveDataBase.deletePostFromHive(tempData);
    resetWriteState();
    update();
  }

  //일기 리스트를 전부 제거하고 조커를 추가합니다.
  void deletePostListAll() {
    _postlist.removeRange(0, _postlist.length);
    _postlist.add(k_NotWritePost);
  }
}
