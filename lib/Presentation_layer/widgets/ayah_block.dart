import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/audio_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AyahBlock extends StatelessWidget {
  const AyahBlock({required this.headIndex, super.key});
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
          return Column(
            children: List.generate(
                controller.model.value.heads[headIndex].scripts.length,
                (index) {
              return Container(
                  color: controller.getColor(headIndex, index),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.model.value.heads[headIndex]
                                .scripts[index].number
                                .toString()),
                            AyahAudioControllers(
                              headIndex: headIndex,
                              index: index,
                            ),
                          ],
                        ),
                        ArabicAyah(index: index, headIndex: headIndex),
                        Translation(index: index, headIndex: headIndex),
                      ],
                    ),
                  ));
            }),
          );
        }
      }
    });
  }
}

class Translation extends StatelessWidget {
  const Translation({
    super.key,
    required this.headIndex,
    required this.index,
  });

  final int headIndex;
  final int index;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Obx(() {
      return Text(controller.model.value.heads[headIndex].translations[index]);
    });
  }
}

class ArabicAyah extends StatelessWidget {
  const ArabicAyah({super.key, required this.headIndex, required this.index});

  final int headIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Text(controller.model.value.heads[headIndex].scripts[index].script,
        textDirection: TextDirection.rtl);
  }
}

class AyahAudioControllers extends StatelessWidget {
  const AyahAudioControllers(
      {required this.headIndex, required this.index, super.key});

  final int headIndex;
  final int index;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.put(QuranController());
    return Container(
      color: controller.getColor(headIndex, index),
      child: Obx(() {
        if (controller.model.value.heads.isNotEmpty) {
          if (controller.model.value.heads[headIndex].headSystemState ==
              AudioState.stopped) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                    visible: controller
                            .model.value.heads[headIndex].ayahSystemState ==
                        AudioState.stopped,
                    child: IconButton(
                        onPressed: () {
                          controller.updateAyahSysytem(
                              headIndex, AudioState.playing);
                          controller.play(urls: [
                            controller
                                .model.value.heads[headIndex].audiosPaths[index]
                          ], headIndex: headIndex);
                          controller.updateAyahPlaying(headIndex, index);
                        },
                        icon: const Icon(
                          Icons.play_arrow,
                          size: 30,
                        ))),
                Visibility(
                    visible: controller
                                .model.value.heads[headIndex].ayahSystemState ==
                            AudioState.playing &&
                        controller.model.value.heads[headIndex]
                                .playingAyahIndex ==
                            index,
                    child: IconButton(
                        onPressed: () {
                          controller.updateAyahSysytem(
                              headIndex, AudioState.paused);

                          controller.pause(headIndex);
                        },
                        icon: const Icon(
                          Icons.pause,
                          size: 30,
                        ))),
                Visibility(
                    visible: controller
                                .model.value.heads[headIndex].ayahSystemState ==
                            AudioState.paused &&
                        controller.model.value.heads[headIndex]
                                .playingAyahIndex ==
                            index,
                    child: IconButton(
                        onPressed: () {
                          controller.updateAyahSysytem(
                              headIndex, AudioState.playing);

                          controller.resume(headIndex);
                        },
                        icon: const Icon(
                          Icons.play_circle,
                          size: 30,
                        ))),
                Visibility(
                    visible: (controller.model.value.heads[headIndex]
                                    .ayahSystemState ==
                                AudioState.playing ||
                            controller.model.value.heads[headIndex]
                                    .ayahSystemState ==
                                AudioState.paused) &&
                        controller.model.value.heads[headIndex]
                                .playingAyahIndex ==
                            index,
                    child: IconButton(
                        onPressed: () {
                          controller.updateAyahSysytem(
                              headIndex, AudioState.stopped);

                          controller.stop(headIndex);
                        },
                        icon: const Icon(
                          Icons.stop,
                          size: 30,
                        )))
              ],
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      }),
    );
  }
}
