import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/audio_state.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/paths_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAyahBlock extends StatelessWidget {
  const MyAyahBlock({required this.headIndex, super.key});
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: List.generate(
                  controller.model.value.heads[headIndex].scripts.length,
                  (index) {
                return Container(
                    key: controller.model.value.heads[headIndex].keys[index],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          AyahNumberAndOperations(
                              index: index, headIndex: headIndex),
                          ArabicMyAyah(index: index, headIndex: headIndex),
                          Translation(index: index, headIndex: headIndex),
                        ],
                      ),
                    ));
              }),
            ),
          );
        }
      }
    });
  }
}

class AyahNumberAndOperations extends StatelessWidget {
  const AyahNumberAndOperations({
    super.key,
    required this.index,
    required this.headIndex,
  });

  final int headIndex;
  final int index;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AyahsPaths.ayah4))),
            child: Center(
              child: Text(
                controller.model.value.heads[headIndex].scripts[index].number
                    .toString(),
                style: const TextStyle(color: ColorsConst.yDarkBlueColor),
              ),
            ),
          ),
          Row(
            children: [
              MyAyahAudioControllers(
                headIndex: headIndex,
                index: index,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                    color: ColorsConst.yDarkBlueColor,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.copy,
                      color: ColorsConst.yDarkBlueColor)),
            ],
          )
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
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          controller.model.value.heads[headIndex].translations[index],
          style: TextStyle(
              color: ColorsConst.yDarkBlueColor,
              fontSize: controller.getFontSize(headIndex, index),
              fontWeight: controller.getFontWeight(headIndex, index)),
        ),
      );
    });
  }
}

class ArabicMyAyah extends StatelessWidget {
  const ArabicMyAyah({super.key, required this.headIndex, required this.index});

  final int headIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Align(
      alignment: Alignment.centerRight,
      child: Text(controller.model.value.heads[headIndex].scripts[index].script,
          textDirection: TextDirection.rtl,
          style: TextStyle(
              color: ColorsConst.yDarkBlueColor,
              fontSize: controller.getFontSize(headIndex, index),
              fontWeight: controller.getFontWeight(headIndex, index))),
    );
  }
}

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
