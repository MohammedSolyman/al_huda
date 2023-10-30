import 'package:al_huda/Presentation_layer/controllers/quran_controllers/quran_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArabicAyah extends StatelessWidget {
  const ArabicAyah({super.key, required this.headIndex, required this.index});

  final int headIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Align(
      alignment: Alignment.centerRight,
      child: Text(controller.model.value.heads[headIndex].scripts[index].script,
          textDirection: TextDirection.rtl,
          style: controller.getTextStyle(headIndex, index)),
    );
  }
}
