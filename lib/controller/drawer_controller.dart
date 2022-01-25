import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawerController extends GetxController {
  //---------------------------------------------------------
  //변수
  bool _isShowIndicator = false;

  //---------------------------------------------------------
  // 함수
  bool getIsShowIndicator() => _isShowIndicator;

  // 인디케이터 표시 유무
  void setIsShowIndicator(bool state) {
    _isShowIndicator = state;
    update();
  }

  // 개발자에게 메일 보내기
  void mailToDeveloper() async {
    final Uri scheme = Uri(
        scheme: "mailto",
        path: "jamg123123@naver.com",
        query: encodeQueryParameters(<String, String>{
          "subject": "[15Minute Diary] 에러신고",
          "body": "사용하시는 휴대폰 기종, OS와 함께 에러 내용을 적어주세요.\nOS: \n기종: \n: 에러내용: "
        }));
    if (!await launch(scheme.toString())) throw 'Could not launch $scheme';
  }

  // Uri Query부분의 파라미터 파싱
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
