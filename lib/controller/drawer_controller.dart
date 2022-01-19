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
    final Uri scheme = Uri(
        scheme: "mailto",
        path: "jamg123123@naver.com",
        query: encodeQueryParameters(<String, String>{
          "subject": "[15Minute Diary] 에러신고",
          "body": "사용하시는 휴대폰 기종, OS와 함께 에러 내용을 적어주세요."
        }));
    if (!await launch(scheme.toString())) throw 'Could not launch $scheme';
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
