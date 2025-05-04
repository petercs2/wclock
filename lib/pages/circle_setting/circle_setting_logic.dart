import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CircleSettingLogic extends GetxController {

  int colorType = Get.arguments;

  var time24 = true.obs;
  var f = true.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    time24.value = prefs.getBool('time24') ?? true;
    f.value = prefs.getBool('fahrenheit') ?? true;
    super.onInit();
  }

}
