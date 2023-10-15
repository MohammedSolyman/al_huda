import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Head extends StatelessWidget {
  //this includes arabic and language chapter's names.
  //under this head, the all ayahs of chapter will be listed (in case of chapter
  // view),or some of ayahs of this chapter will be listed (in case of juz view).
  //this includes also audio controllers which plays the list of ayahs under
  //this head.

  const Head({required this.headIndex, super.key});

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
      if (!controller.model.value.heads.isEmpty) {
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
          Text(
            controller.model.value.heads.isEmpty
                ? '...'
                : controller.model.value.heads[headIndex].languageName,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          Text(
            controller.model.value.heads.isEmpty
                ? '...'
                : controller.model.value.heads[headIndex].arabicName,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        controller.toggleChapterInfoVisibility(headIndex);
                      },
                      icon: Icon(
                        Icons.info,
                        color: Colors.white,
                      )),
                  TranslationSettings(),
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
        if (controller.model.value.heads[0].headSound) {
          return Row(
            children: [
              IconButton(
                  onPressed: () {
                    controller.play(
                        urls: controller.model.value.heads[0].audiosPaths!,
                        headIndex: headIndex);
                  },
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.lightGreen,
                    size: 40,
                  )),
              IconButton(
                  onPressed: () {
                    controller.pause(headIndex);
                  },
                  icon: const Icon(
                    Icons.pause,
                    color: Colors.lightGreen,
                    size: 40,
                  )),
              IconButton(
                  onPressed: () {
                    controller.resume(headIndex);
                  },
                  icon: const Icon(
                    Icons.play_circle,
                    color: Colors.lightGreen,
                    size: 40,
                  )),
              IconButton(
                  onPressed: () {
                    controller.stop(headIndex);
                  },
                  icon: const Icon(
                    Icons.stop,
                    color: Colors.lightGreen,
                    size: 40,
                  )),
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

class TranslationSettings extends StatelessWidget {
  const TranslationSettings({super.key});

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
                      controller.model.value.languageTranslations[index].id!);
                },
              );
            });

            return x;
          }
        });
  }
}
