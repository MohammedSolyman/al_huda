// ignore_for_file: prefer_const_constructors

import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/audio_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeadBlock extends StatelessWidget {
  //this includes arabic and language chapter's names.
  //under this head, the all MyAyahs of chapter will be listed (in case of chapter
  // view),or some of MyAyahs of this chapter will be listed (in case of juz view).
  //this includes also audio controllers which plays the list of MyAyahs under
  //this head.

  HeadBlock({this.guzNumber, required this.headIndex, super.key});

  final int headIndex;
  int? guzNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          NameBlock(headIndex: headIndex, guzNumber: guzNumber),
          InfoBock(headIndex: headIndex),
        ],
      ),
    );
  }
}

class InfoBock extends StatelessWidget {
  const InfoBock({required this.headIndex, super.key});

  final int headIndex;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Obx(() {
      if (controller.model.value.heads.isNotEmpty) {
        if (controller.model.value.heads[headIndex].showInfo) {
          return Container(
            color: Colors.yellow,
            child: Text(
                controller.model.value.heads[headIndex].chapterInfo == ''
                    ? '...'
                    : controller.model.value.heads[headIndex].chapterInfo),
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

class NameBlock extends StatelessWidget {
  final int headIndex;
  int? guzNumber;
  NameBlock({
    this.guzNumber,
    required this.headIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                controller.model.value.heads.isEmpty
                    ? '...'
                    : controller.model.value.heads[headIndex].arabicName,
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
              Text(
                controller.model.value.heads.isEmpty
                    ? '...'
                    : controller.model.value.heads[headIndex].languageName,
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  HeadAudioControllers(headIndex: headIndex),
                  IconButton(
                      onPressed: () {
                        controller.toggleChapterInfoVisibility(headIndex);
                      },
                      icon: const Icon(
                        Icons.info,
                        color: Colors.white,
                      )),
                ],
              ),
            ],
          ),
        ],
      );
    });
  }
}

class HeadAudioControllers extends StatelessWidget {
  const HeadAudioControllers({required this.headIndex, super.key});

  final int headIndex;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.put(QuranController());
    return Obx(() {
      if (controller.model.value.heads.isNotEmpty) {
        return Row(
          children: [
            Visibility(
                visible:
                    controller.model.value.heads[headIndex].headSystemState ==
                        AudioState.stopped,
                child: IconButton(
                    onPressed: () {
                      controller.updateHeadSystem(
                          headIndex, AudioState.playing);
                      controller.play(
                          urls: controller
                              .model.value.heads[headIndex].audiosPaths,
                          headIndex: headIndex);
                      controller.updateListMyAyahPlaying(headIndex);
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.lightGreen,
                      size: 40,
                    ))),
            Visibility(
                visible:
                    controller.model.value.heads[headIndex].headSystemState ==
                        AudioState.playing,
                child: IconButton(
                    onPressed: () {
                      controller.updateHeadSystem(headIndex, AudioState.paused);
                      controller.pause(headIndex);
                    },
                    icon: const Icon(
                      Icons.pause,
                      color: Colors.lightGreen,
                      size: 40,
                    ))),
            Visibility(
                visible:
                    controller.model.value.heads[headIndex].headSystemState ==
                        AudioState.paused,
                child: IconButton(
                    onPressed: () {
                      controller.updateHeadSystem(
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
                            .model.value.heads[headIndex].headSystemState ==
                        AudioState.playing ||
                    controller.model.value.heads[headIndex].headSystemState ==
                        AudioState.paused,
                child: IconButton(
                    onPressed: () {
                      controller.updateHeadSystem(
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
    });
  }
}
