import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/Presentation_layer/widgets/Settings_block.dart';
import 'package:al_huda/Presentation_layer/widgets/ayah_block.dart';
import 'package:al_huda/Presentation_layer/widgets/head_block.dart';
import 'package:al_huda/util/constants/guzs_chapters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuzView extends StatelessWidget {
  const GuzView({required this.guzNumber, super.key});
  final int guzNumber;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.put(QuranController());
    controller.createHeadValues(guzNumber: guzNumber);

    return Scaffold(
        body: Column(
      children: [
        SettingsBlock(guzNumber: guzNumber),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                  GuzsChaptersConstant.guzsChapters[guzNumber]!.length,
                  (headIndex) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HeadBlock(
                            headIndex: headIndex,
                            guzNumber: guzNumber,
                          ),
                          AyahBlock(headIndex: headIndex)
                        ],
                      )),
            ),
          ),
        )
      ],
    ));
  }
}
