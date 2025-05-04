import 'package:circle_clock/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import 'circle_setting_logic.dart';

class CircleSettingPage extends GetView<CircleSettingLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: null,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(child: GetBuilder<CircleSettingLogic>(builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              Expanded(
                  child: <Widget>[
                const Text('Preview background color',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemCount: graList.length,
                    itemBuilder: (_, index) {
                      return LayoutBuilder(builder: (_, max) {
                        return <Widget>[
                          Container().decorated(
                              gradient: LinearGradient(
                                  colors: graList[index],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius:
                                  BorderRadius.circular(max.maxWidth / 2)),
                          Visibility(
                              visible: controller.colorType == index,
                              child: Image.asset(
                                'assets/ar.webp',
                                width: 22,
                                height: 22,
                                fit: BoxFit.cover,
                              ))
                        ]
                            .toStack(
                          alignment: Alignment.center,
                        )
                            .gestures(onTap: () async {
                          controller.colorType = index;
                          controller.update();
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setInt('colorType', index);
                        });
                      });
                    })
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                  child: <Widget>[
                const Text(
                  'Other setting',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                <Widget>[
                  Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.transparent,
                    child: <Widget>[
                      const Text('24-hour display'),
                      Obx(() {
                        return Switch(
                            value: controller.time24.value,
                            activeTrackColor: Colors.green,
                            onChanged: (v) async {
                              controller.time24.value = v;
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('time24', v);
                            });
                      })
                    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.transparent,
                    child: <Widget>[
                      const Text('Fahrenheit'),
                      Obx(() {
                        return Switch(
                            value: controller.f.value,
                            activeTrackColor: Colors.green,
                            onChanged: (v) async {
                              controller.f.value = v;
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('fahrenheit', v);
                            });
                      })
                    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    color: Colors.transparent,
                    child: <Widget>[
                      const Text('About us'),
                      const Text("1.0.0",style: TextStyle(color: Colors.grey),).paddingOnly(right: 12),
                    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  )
                ].toColumn(
                    separator: Divider(
                  height: 15,
                  color: Colors.grey.shade300,
                ))
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start))
            ].toRow(crossAxisAlignment: CrossAxisAlignment.start),
          );
        })),
      ),
    );
  }
}
