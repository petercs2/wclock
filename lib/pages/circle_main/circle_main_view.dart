import 'package:analog_clock/analog_clock.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import 'circle_main_logic.dart';

class CircleMainPage extends StatefulWidget {
  const CircleMainPage({Key? key}) : super(key: key);

  @override
  State<CircleMainPage> createState() => _CircleMainPageState();
}

class _CircleMainPageState extends State<CircleMainPage> {
  CircleMainLogic controller = Get.find<CircleMainLogic>();

  void xjiochaihns() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      Get.toNamed('/localNet');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    xjiochaihns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CircleMainLogic>(builder: (_) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
              child: <Widget>[
            <Widget>[
              <Widget>[
                <Widget>[
                  const Icon(
                    Icons.keyboard_arrow_left,
                    size: 60,
                    color: Colors.white,
                  ).gestures(onTap: () async {
                    controller.dialType--;
                    if (controller.dialType < 0) {
                      controller.dialType = 3;
                    }
                    controller.update();
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setInt('dialType', controller.dialType);
                  }),
                  AnalogClock(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/img${controller.dialType}.webp'),
                            fit: BoxFit.cover)),
                    width: 250,
                    height: 250,
                    hourHandColor: Colors.white,
                    minuteHandColor: Colors.grey,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    size: 60,
                    color: Colors.white,
                  ).gestures(onTap: () async {
                    controller.dialType++;
                    if (controller.dialType > 3) {
                      controller.dialType = 0;
                    }
                    controller.update();
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setInt('dialType', controller.dialType);
                  })
                ].toRow(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.hmdStr.value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )
              ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
              <Widget>[
                <Widget>[
                  Text(
                    controller.hmStr.value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 77,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    controller.apmStr.value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ).marginOnly(top: 20)
                ].toRow(crossAxisAlignment: CrossAxisAlignment.start),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: <Widget>[
                    Image.asset(
                      'assets/icon${controller.type.value}.webp',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    <Widget>[
                      Text(
                        controller.cityName.value,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      <Widget>[
                        Text(
                          controller.typeStr.value,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          controller.fahrenheit.value
                              ? '${controller.f.value.toInt()}°F'
                              : '${controller.c.value.toInt()}°C',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ].toRow()
                    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)
                  ].toRow(),
                ).decorated(
                    color: Colors.black.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(17))
              ].toColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start)
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            Positioned(
                bottom: 0,
                right: 0,
                child: const Icon(
                  Icons.settings,
                  size: 35,
                  color: Colors.white,
                ).gestures(onTap: () {
                  Get.toNamed('/circleSetting', arguments: controller.colorType)
                      ?.then((_) {
                    controller.startTimer();
                  });
                }))
          ].toStack(alignment: Alignment.center)),
        ).decorated(
            gradient: LinearGradient(
                colors: controller.colorList.value,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter));
      }),
    );
  }
}
