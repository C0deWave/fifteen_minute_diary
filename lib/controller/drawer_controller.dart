import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawerController extends GetxController {
  bool _isShowIndicator = false;

  bool getIsShowIndicator() => _isShowIndicator;

  void setIsShowIndicator(bool state) {
    _isShowIndicator = state;
    update();
  }

  void mailToDeveloper() async {
    String _url =
        'mailto:jamg123123@naver.com?subject=[15Minute Diary] 에러신고&body=에러내용, 사용기기, os버전을 작성해 주세요.';
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
