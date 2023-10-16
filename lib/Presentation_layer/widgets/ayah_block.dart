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

    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Obx(() {
          if (controller.model.value.heads.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (controller.model.value.heads[headIndex].scripts!.isEmpty) {
              return const Text('...');
            } else {
              return Expanded(
                child: ListView.builder(
                    itemCount:
                        controller.model.value.heads[headIndex].scripts!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          decoration: BoxDecoration(
                              color: controller.getColor(headIndex, index),
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AyahANdTrasnlation(
                                  index: index, headIndex: headIndex),
                              AyahAudioControllers(
                                headIndex: headIndex,
                                index: index,
                              )
                            ],
                          ));
                    }),
              );
            }
          }
        }),
      ),
    );
  }
}

class AyahANdTrasnlation extends StatelessWidget {
  const AyahANdTrasnlation({
    super.key,
    required this.headIndex,
    required this.index,
  });

  final int headIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArabicAyah(index: index, headIndex: headIndex),
          Translation(index: index, headIndex: headIndex),
        ],
      ),
    );
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
      return Text(controller.model.value.heads[headIndex].translations![index]);
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(controller.model.value.heads[headIndex].scripts![index].number
            .toString()),
        Text(controller.model.value.heads[headIndex].scripts![index].script,
            textDirection: TextDirection.rtl),
      ],
    );
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
    return Obx(() {
      if (controller.model.value.heads.isNotEmpty) {
        if (controller.model.value.heads[headIndex].headSystemState ==
            AudioState.stopped) {
          return Row(
            children: [
              Visibility(
                  visible:
                      controller.model.value.heads[headIndex].ayahSystemState ==
                          AudioState.stopped,
                  child: IconButton(
                      onPressed: () {
                        controller.updateAyahSysytem(
                            headIndex, AudioState.playing);
                        controller.play(urls: [
                          controller
                              .model.value.heads[headIndex].audiosPaths![index]
                        ], headIndex: headIndex);
                      },
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Colors.lightGreen,
                        size: 40,
                      ))),
              Visibility(
                  visible:
                      controller.model.value.heads[headIndex].ayahSystemState ==
                          AudioState.playing,
                  child: IconButton(
                      onPressed: () {
                        controller.updateAyahSysytem(
                            headIndex, AudioState.paused);

                        controller.pause(headIndex);
                      },
                      icon: const Icon(
                        Icons.pause,
                        color: Colors.lightGreen,
                        size: 40,
                      ))),
              Visibility(
                  visible:
                      controller.model.value.heads[headIndex].ayahSystemState ==
                          AudioState.paused,
                  child: IconButton(
                      onPressed: () {
                        controller.updateAyahSysytem(
                            headIndex, AudioState.playing);

                        controller.resume(headIndex);
                      },
                      icon: const Icon(
                        Icons.play_circle,
                        color: Colors.lightGreen,
                        size: 40,
                      ))),
              Visibility(
                  visible: controller
                              .model.value.heads[headIndex].ayahSystemState ==
                          AudioState.playing ||
                      controller.model.value.heads[headIndex].ayahSystemState ==
                          AudioState.paused,
                  child: IconButton(
                      onPressed: () {
                        controller.updateAyahSysytem(
                            headIndex, AudioState.stopped);

                        controller.stop(headIndex);
                      },
                      icon: const Icon(
                        Icons.stop,
                        color: Colors.lightGreen,
                        size: 40,
                      )))
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
