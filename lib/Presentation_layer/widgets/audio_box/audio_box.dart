import 'package:al_huda/Presentation_layer/controllers/my_animation_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/audio_state.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioBox extends StatelessWidget {
  const AudioBox({required this.headIndex, super.key});

  final int headIndex;
  @override
  Widget build(BuildContext context) {
    MyAnimationController aController = Get.find<MyAnimationController>();

    return Obx(
      () {
        return Positioned(
          top: aController.model.value.audioBoxTop,
          left: aController.model.value.audioBoxLeft,
          child: Container(
              width: aController.model.value.audioBoxWidth,
              height: aController.model.value.audioBoxHeight,
              decoration: const BoxDecoration(color: Colors.yellow),
              child: Row(
                children: [
                  AudioBoxControllers(
                    headIndex: headIndex,
                  )
                ],
              )),
        );
      },
    );
  }
}

class AudioBoxControllers extends StatelessWidget {
  const AudioBoxControllers({required this.headIndex, super.key});

  final int headIndex;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();
    MyAnimationController aController = Get.find<MyAnimationController>();

    return Obx(() {
      if (controller.model.value.heads.isNotEmpty) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
                visible:
                    controller.model.value.heads[headIndex].headSystemState ==
                        AudioState.playing,
                child: SizedBox(
                  height: 25,
                  child: IconButton(
                      onPressed: () {
                        controller.updateHeadSystem(
                            headIndex, AudioState.paused);
                        controller.pause(headIndex);
                      },
                      icon: const Icon(
                        Icons.pause,
                        color: ColorsConst.yDarkBlueColor,
                        size: 30,
                      )),
                )),
            Visibility(
                visible:
                    controller.model.value.heads[headIndex].headSystemState ==
                        AudioState.paused,
                child: SizedBox(
                  height: 25,
                  child: IconButton(
                      onPressed: () {
                        controller.updateHeadSystem(
                            headIndex, AudioState.playing);

                        controller.resume(headIndex);
                      },
                      icon: const Icon(
                        Icons.play_circle,
                        color: ColorsConst.yDarkBlueColor,
                        size: 30,
                      )),
                )),
            Visibility(
                visible: controller
                            .model.value.heads[headIndex].headSystemState ==
                        AudioState.playing ||
                    controller.model.value.heads[headIndex].headSystemState ==
                        AudioState.paused,
                child: SizedBox(
                  height: 25,
                  child: IconButton(
                      onPressed: () {
                        controller.updateHeadSystem(
                            headIndex, AudioState.stopped);
                        controller.stop(headIndex);
                        aController.reverseAnimation();
                      },
                      icon: const Icon(
                        Icons.stop,
                        color: ColorsConst.yDarkBlueColor,
                        size: 30,
                      )),
                ))
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
