import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
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
    print('$guzNumber -----------------from GuzView');

    return Scaffold(
        body: SingleChildScrollView(
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
                    Column(
                      children: List.generate(
                          controller
                              .model.value.heads[headIndex].scripts!.length,
                          (index) => Column(
                                children: [
                                  Text(controller.model.value.heads[headIndex]
                                      .scripts[index].script),
                                  Text(controller.model.value.heads[headIndex]
                                      .translations[index]),
                                ],
                              )),
                    )
                  ],
                )),
      ),
    ));
  }
}
