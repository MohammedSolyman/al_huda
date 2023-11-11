import 'package:al_huda/Presentation_layer/controllers/quran_controllers/my_animation_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controllers/quran_controller.dart';
import 'package:al_huda/util/constants/audio_state.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          controller.updateHeadSystem(headIndex, AudioState.stopped);
          aController.reverseAnimation();
        },
        icon: Icon(
          Icons.stop,
          color: BlueColor.blueColor.shade400,
          size: 30,
        ));
  }
}
