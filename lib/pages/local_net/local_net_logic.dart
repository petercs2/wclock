import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LocalNetLogic extends GetxController {

  void ankjbcmkjs() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      Fluttertoast.showToast(msg: 'Check the network and try again');
    } else {
      Fluttertoast.showToast(msg: 'You are connected to the internet');
      Get.back();
    }
  }

}
