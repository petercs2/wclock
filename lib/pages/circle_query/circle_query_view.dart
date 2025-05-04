import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'circle_query_logic.dart';

class CircleQueryView extends GetView<CircleQueryLogic> {
  const CircleQueryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.pagac.value
              ? const CircularProgressIndicator(color: Colors.grey)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.rwvcdsi();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
