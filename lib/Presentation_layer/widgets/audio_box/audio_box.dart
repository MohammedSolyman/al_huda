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
              decoration: BoxDecoration(
                  border: Border.all(
                    color: BlueColor.blueColor.shade900,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(colors: [
                    SeaColor.SeaColorAccents.shade100,
                    SeaColor.SeaColorAccents.shade200,
                    SeaColor.SeaColorAccents.shade400,
                    SeaColor.SeaColorAccents.shade700,
                  ]),
                  boxShadow: [
                    BoxShadow(
                        color: BlueColor.blueColor.shade900,
                        blurRadius: 5,
                        offset: Offset(1, 1))
                  ]),
              child: AudioBoxControllers(
                headIndex: headIndex,
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

    return Obx(() {
      if (controller.model.value.heads.isNotEmpty) {
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PauseOrResume(headIndex: headIndex),
              Stop(
                headIndex: headIndex,
              )
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}

class PauseOrResume extends StatelessWidget {
  const PauseOrResume({required this.headIndex, super.key});

  final int headIndex;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    if (controller.model.value.heads[headIndex].headSystemState ==
        AudioState.playing) {
      return IconButton(
          onPressed: () {
            controller.updateHeadSystem(headIndex, AudioState.paused);
            controller.pause(headIndex);
          },
          icon: Icon(
            Icons.pause,
            color: BlueColor.blueColor.shade400,
            size: 30,
          ));
    } else {
      return IconButton(
          onPressed: () {
            controller.updateHeadSystem(headIndex, AudioState.playing);

            controller.resume(headIndex);
          },
          icon: Icon(
            Icons.play_circle,
            color: BlueColor.blueColor.shade400,
            size: 30,
          ));
    }
  }
}

class Stop extends StatelessWidget {
  const Stop({required this.headIndex, super.key});

  final int headIndex;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();
    MyAnimationController aController = Get.find<MyAnimationController>();

    return IconButton(
        onPressed: () {
          controller.updateHeadSystem(headIndex, AudioState.stopped);
          controller.stop(headIndex);
          aController.reverseAnimation();
        },
        icon: Icon(
          Icons.stop,
          color: BlueColor.blueColor.shade400,
          size: 30,
        ));
  }
}
