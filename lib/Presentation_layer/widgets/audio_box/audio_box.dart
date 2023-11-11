import 'package:al_huda/Presentation_layer/controllers/quran_controllers/my_animation_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controllers/quran_controller.dart';
import 'package:al_huda/Presentation_layer/widgets/audio_box/components/audio_box_audio_controllers.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioBox extends StatelessWidget {
  const AudioBox({super.key});

  @override
  Widget build(BuildContext context) {
    MyAnimationController aController = Get.find<MyAnimationController>();
    QuranController qContoller = Get.find<QuranController>();

    return Obx(
      () {
        int headIndex = qContoller.model.value.headPlaying == -1
            ? 0
            : qContoller.model.value.headPlaying;
        return Positioned(
          top: aController.model.value.audioBoxTop,
          left: aController.model.value.audioBoxLeft,
          child: Container(
              width: aController.model.value.audioBoxWidth,
              height: aController.model.value.audioBoxHeight,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: BlueColor.blueColor.shade900,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(colors: [
                    SeaColor.seaColorAccents.shade100,
                    SeaColor.seaColorAccents.shade200,
                    SeaColor.seaColorAccents.shade400,
                    SeaColor.seaColorAccents.shade700,
                  ]),
                  boxShadow: [
                    BoxShadow(
                        color: BlueColor.blueColor.shade900,
                        blurRadius: 5,
                        offset: const Offset(1, 1))
                  ]),
              child: AudioBoxControllers(
                headIndex: headIndex,
              )),
        );
      },
    );
  }
}
