import 'package:get/get.dart';

import 'circle_query_logic.dart';

class CircleQueryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      CircleQueryLogic(),
      permanent: true,
    );
  }
}
