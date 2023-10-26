import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/paths_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoBlock extends StatelessWidget {
  const InfoBlock({required this.headIndex, super.key});

  final int headIndex;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Obx(() {
      if (controller.model.value.heads.isNotEmpty) {
        if (controller.model.value.heads[headIndex].showInfo) {
          return Column(
            children: [
              Image.asset(FramesPaths.frame2),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  color: SkyColor.skyColor.shade500,
                  child: Text(
                    controller.model.value.heads[headIndex].chapterInfo == ''
                        ? '...'
                        : controller.model.value.heads[headIndex].chapterInfo,
                    style: TextStyle(
                        color: BlueColor.blueColor.shade400,
                        fontSize: TextSizes.normal),
                  ),
                ),
              ),
              Image.asset(FramesPaths.frame2),
            ],
          );
        } else {
          return Container();
        }
      } else {
        return Container();
      }
    });
  }
}
