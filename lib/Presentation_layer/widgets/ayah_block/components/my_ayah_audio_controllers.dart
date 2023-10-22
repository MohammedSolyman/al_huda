import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/audio_state.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAyahAudioControllers extends StatelessWidget {
  const MyAyahAudioControllers(
      {required this.headIndex, required this.index, super.key});

  final int headIndex;
  final int index;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.put(QuranController());
    return Obx(() {
      if (controller.model.value.heads.isNotEmpty) {
        if (controller.model.value.heads[headIndex].headSystemState ==
            AudioState.stopped) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                  visible: controller
                          .model.value.heads[headIndex].myAyahSystemState ==
                      AudioState.stopped,
                  child: IconButton(
                      onPressed: () {
                        controller.updateMyAyahSysytem(
                            headIndex, AudioState.playing);
                        controller.play(urls: [
                          controller
                              .model.value.heads[headIndex].audiosPaths[index]
                        ], headIndex: headIndex);
                        controller.updateMyAyahPlaying(headIndex, index);
                      },
                      icon: const Icon(Icons.play_arrow,
                          size: 30, color: ColorsConst.yDarkBlueColor))),
              Visibility(
                  visible: controller
                              .model.value.heads[headIndex].myAyahSystemState ==
                          AudioState.playing &&
                      controller.model.value.heads[headIndex]
                              .playingMyAyahIndex ==
                          index,
                  child: IconButton(
                      onPressed: () {
                        controller.updateMyAyahSysytem(
                            headIndex, AudioState.paused);

                        controller.pause(headIndex);
                      },
                      icon: const Icon(Icons.pause,
                          size: 30, color: ColorsConst.yDarkBlueColor))),
              Visibility(
                  visible: controller
                              .model.value.heads[headIndex].myAyahSystemState ==
                          AudioState.paused &&
                      controller.model.value.heads[headIndex]
                              .playingMyAyahIndex ==
                          index,
                  child: IconButton(
                      onPressed: () {
                        controller.updateMyAyahSysytem(
                            headIndex, AudioState.playing);

                        controller.resume(headIndex);
                      },
                      icon: const Icon(Icons.play_circle,
                          size: 30, color: ColorsConst.yDarkBlueColor))),
              Visibility(
                  visible: (controller.model.value.heads[headIndex]
                                  .myAyahSystemState ==
                              AudioState.playing ||
                          controller.model.value.heads[headIndex]
                                  .myAyahSystemState ==
                              AudioState.paused) &&
                      controller.model.value.heads[headIndex]
                              .playingMyAyahIndex ==
                          index,
                  child: IconButton(
                      onPressed: () {
                        controller.updateMyAyahSysytem(
                            headIndex, AudioState.stopped);

                        controller.stop(headIndex);
                      },
                      icon: const Icon(Icons.stop,
                          size: 30, color: ColorsConst.yDarkBlueColor)))
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
