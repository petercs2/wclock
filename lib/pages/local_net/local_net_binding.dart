import 'package:get/get.dart';

import 'local_net_logic.dart';

class LocalNetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocalNetLogic());
  }
}
