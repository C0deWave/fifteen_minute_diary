//main에서 페이지 라우팅을 할때 바인딩에 이용합니다.
import 'package:fifteen_minute_diary/controller/post_controller.dart';
import 'package:get/get.dart';

class PostBinder implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostController());
  }
}
