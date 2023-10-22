// ignore_for_file: prefer_const_constructors

import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/audio_state.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/paths_consts.dart';
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
    return Column(
      children: [
        NameBlock(headIndex: headIndex, guzNumber: guzNumber),
        InfoBock(headIndex: headIndex),
      ],
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
          return Column(
            children: [
              Image.asset(FramesPaths.frame2),
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  color: ColorsConst.blueLight,
                  child: Text(
                      controller.model.value.heads[headIndex].chapterInfo == ''
                          ? '...'
                          : controller
                              .model.value.heads[headIndex].chapterInfo),
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
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 180,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/surah/surah2.png',
              ),
              fit: BoxFit.fill)),
      child: Container(
        margin: EdgeInsets.fromLTRB(width * 0.28, 40, width * 0.28, 40),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SurahNames(headIndex: headIndex),
              SurahControllers(
                headIndex: headIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SurahControllers extends StatelessWidget {
  const SurahControllers({
    super.key,
    required this.headIndex,
  });

  final int headIndex;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();
    return Row(
      children: [
        SizedBox(
          width: 5,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.cyan, borderRadius: BorderRadius.circular(50)),
          width: 3,
          height: 60,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeadAudioControllers(headIndex: headIndex),
            IconButton(
                onPressed: () {
                  controller.toggleChapterInfoVisibility(headIndex);
                },
                icon: const Icon(
                  Icons.info,
                  size: 20,
                  color: ColorsConst.yDarkBlueColor,
                )),
          ],
        ),
      ],
    );
  }
}

class SurahNames extends StatelessWidget {
  const SurahNames({
    super.key,
    required this.headIndex,
  });

  final int headIndex;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.model.value.heads.isEmpty
                ? '...'
                : controller.model.value.heads[headIndex].arabicName,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorsConst.yDarkBlueColor,
                fontSize: 15),
          ),
          Text(
            controller.model.value.heads.isEmpty
                ? '...'
                : controller.model.value.heads[headIndex].languageName,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorsConst.yDarkBlueColor,
                fontSize: 15),
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
                visible:
                    controller.model.value.heads[headIndex].headSystemState ==
                        AudioState.stopped,
                child: SizedBox(
                  height: 25,
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
                        color: ColorsConst.yDarkBlueColor,
                        size: 30,
                      )),
                )),
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
