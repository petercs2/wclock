import 'package:get/get.dart';

import 'circle_main_logic.dart';

class CircleMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CircleMainLogic());
  }
}
