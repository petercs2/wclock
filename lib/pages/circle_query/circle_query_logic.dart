import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void bvoabouh() async {
  var connectResult = await (Connectivity().checkConnectivity());
  if(connectResult == ConnectivityResult.none){
    Get.toNamed("/localNet");
  }
}

class CircleQueryLogic extends GetxController {

  var bgtjzik = RxBool(false);
  var opsfba = RxBool(true);
  var hqszid = RxString("");
  var conor = RxBool(false);
  var pagac = RxBool(true);
  final wjvadozskh = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    bvoabouh();
    super.onInit();
    rwvcdsi();
  }


  Future<void> rwvcdsi() async {

    conor.value = true;
    pagac.value = true;
    opsfba.value = false;

    wjvadozskh.post("https://rain.bcdwomu.com/tlxfazrhukcmnoy",data: await lzmcewij()).then((value) {
      var vnpqekr = value.data["vnpqekr"] as String;
      var wshbqgvm = value.data["wshbqgvm"] as bool;
      if (wshbqgvm) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        hqszid.value = vnpqekr;
        hertha();
      } else {
        medhurst();
      }
    }).catchError((e) {
      opsfba.value = true;
      pagac.value = true;
      conor.value = false;
    });
  }

  Future<Map<String, dynamic>> lzmcewij() async {
    final DeviceInfoPlugin hgyrq = DeviceInfoPlugin();
    PackageInfo kani_tolhagnc = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var xqug = Platform.localeName;
    var fdzn_Gm = currentTimeZone;

    var fdzn_AL = kani_tolhagnc.packageName;
    var fdzn_yHFh = kani_tolhagnc.version;
    var fdzn_TAHYjfFu = kani_tolhagnc.buildNumber;

    var fdzn_FRsWu = kani_tolhagnc.appName;
    var fdzn_xtbWu = "";
    var fdzn_IqgB  = "";
    var fdzn_YIE = "";
    var skylarPollich = "";
    var royAbbott = "";
    var ericMante = "";


    var fdzn_DLTM = "";
    var fdzn_aGyrVzt = false;

    if (GetPlatform.isAndroid) {
      fdzn_DLTM = "android";
      var fzhistk = await hgyrq.androidInfo;

      fdzn_YIE = fzhistk.brand;

      fdzn_xtbWu  = fzhistk.model;
      fdzn_IqgB = fzhistk.id;

      fdzn_aGyrVzt = fzhistk.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      fdzn_DLTM = "ios";
      var tbpmxs = await hgyrq.iosInfo;
      fdzn_YIE = tbpmxs.name;
      fdzn_xtbWu = tbpmxs.model;

      fdzn_IqgB = tbpmxs.identifierForVendor ?? "";
      fdzn_aGyrVzt  = tbpmxs.isPhysicalDevice;
    }
    var res = {
      "fdzn_DLTM": fdzn_DLTM,
      "fdzn_yHFh": fdzn_yHFh,
      "fdzn_AL": fdzn_AL,
      "skylarPollich" : skylarPollich,
      "fdzn_FRsWu": fdzn_FRsWu,
      "fdzn_TAHYjfFu": fdzn_TAHYjfFu,
      "fdzn_Gm": fdzn_Gm,
      "fdzn_YIE": fdzn_YIE,
      "fdzn_IqgB": fdzn_IqgB,
      "xqug": xqug,
      "fdzn_aGyrVzt": fdzn_aGyrVzt,
      "royAbbott" : royAbbott,
      "fdzn_xtbWu": fdzn_xtbWu,
      "ericMante" : ericMante,

    };
    return res;
  }

  Future<void> medhurst() async {
    Get.offAllNamed("/circleMain");
  }

  Future<void> hertha() async {
    Get.offAllNamed("/circleCheck");
  }

}
