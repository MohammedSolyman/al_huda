import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/audio_state.dart';
import 'package:al_huda/util/constants/reciters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeadBlock extends StatelessWidget {
  //this includes arabic and language chapter's names.
  //under this head, the all ayahs of chapter will be listed (in case of chapter
  // view),or some of ayahs of this chapter will be listed (in case of juz view).
  //this includes also audio controllers which plays the list of ayahs under
  //this head.

  const HeadBlock({required this.headIndex, super.key});

  final int headIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          NameBlock(headIndex: headIndex),
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

  const NameBlock({
    required this.headIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                controller.model.value.heads.isEmpty
                    ? '...'
                    : controller.model.value.heads[headIndex].arabicName,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                controller.model.value.heads.isEmpty
                    ? '...'
                    : controller.model.value.heads[headIndex].languageName,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        controller.toggleChapterInfoVisibility(headIndex);
                      },
                      icon: const Icon(
                        Icons.info,
                        color: Colors.white,
                      )),
                  TranslationSettings(headIndex: headIndex),
                  RecitersSettings(headIdex: headIndex)
                ],
              ),
              HeadAudioControllers(headIndex: headIndex)
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
                              .model.value.heads[headIndex].audiosPaths!,
                          headIndex: headIndex);
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

class TranslationSettings extends StatelessWidget {
  const TranslationSettings({required this.headIndex, super.key});
  final int headIndex;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return PopupMenuButton(
        icon: const Icon(
          Icons.school,
          color: Colors.white,
        ),
        itemBuilder: (BuildContext context) {
          if (controller.model.value.languageTranslations.isEmpty) {
            List<PopupMenuEntry<dynamic>> x = [
              const PopupMenuItem(
                  child: Text('there is no translations available'))
            ];

            return x;
          } else {
            List<PopupMenuEntry<dynamic>> x = List.generate(
                controller.model.value.languageTranslations.length, (index) {
              return PopupMenuItem(
                child: Text(
                    controller.model.value.languageTranslations[index].name!),
                onTap: () {
                  controller.updateTranslationId(
                      controller.model.value.languageTranslations[index].id!,
                      [headIndex]);
                },
              );
            });

            return x;
          }
        });
  }
}

class RecitersSettings extends StatelessWidget {
  const RecitersSettings({required this.headIdex, super.key});

  final int headIdex;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();
    return PopupMenuButton(
        icon: const Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
        itemBuilder: (BuildContext context) {
          List<PopupMenuEntry<dynamic>> x =
              List.generate(Reciters.reciters.length, (index) {
            return PopupMenuItem(
              child: Text(Reciters.reciters[index].name),
              onTap: () async {
                await controller
                    .updateReciter(Reciters.reciters[index].id, [headIdex]);
              },
            );
          });
          return x;
        });
  }
}
