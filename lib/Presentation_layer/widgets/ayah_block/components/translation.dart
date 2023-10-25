import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Translation extends StatelessWidget {
  const Translation({
    super.key,
    required this.headIndex,
    required this.index,
  });

  final int headIndex;
  final int index;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Obx(() {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(controller.model.value.heads[headIndex].translations[index],
            style: controller.getTextStyle(headIndex, index)),
      );
    });
  }
}
