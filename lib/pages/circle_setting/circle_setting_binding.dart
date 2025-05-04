import 'package:get/get.dart';

import 'circle_setting_logic.dart';

class CircleSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CircleSettingLogic());
  }
}
