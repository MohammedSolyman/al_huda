import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/Presentation_layer/widgets/ayah_block/components/arabic_ayah.dart';
import 'package:al_huda/Presentation_layer/widgets/ayah_block/components/ayah_number_and_operations.dart';
import 'package:al_huda/Presentation_layer/widgets/ayah_block/components/translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class MyAyahBlock extends StatelessWidget {
  const MyAyahBlock({required this.headIndex, super.key});
  final int headIndex;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Obx(() {
      if (controller.model.value.heads.isEmpty) {
        return const Text('---');
      } else {
        if (controller.model.value.heads[headIndex].scripts.isEmpty) {
          return const Text('...');
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: List.generate(
                  controller.model.value.heads[headIndex].scripts.length,
                  (index) {
                return Container(
                    key: controller.model.value.heads[headIndex].keys[index],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          AyahNumberAndOperations(
                              index: index, headIndex: headIndex),
                          ArabicAyah(index: index, headIndex: headIndex),
                          Translation(index: index, headIndex: headIndex),
                        ],
                      ),
                    ));
              }),
            ),
          );
        }
      }
    });
  }
}
