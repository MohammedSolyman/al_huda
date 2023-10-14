import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/widgets/head.dart';
import 'package:al_huda/util/constants/reciters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChapterView extends StatelessWidget {
  final int chapterId;
  final String chapterArabicName;
  final String chapterLanguageName;
  final int versesCount;

  const ChapterView(
      {required this.chapterId,
      required this.versesCount,
      required this.chapterArabicName,
      required this.chapterLanguageName,
      super.key});

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.put(QuranController());
    controller.updateId(chapterId);
    controller.getInfo();

    controller.getChapterIndopack();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Head(
              chapterId: chapterId,
              firstAyah: 1,
              lastAyah: versesCount,
              chapterLanguageName: chapterLanguageName,
              chapterArabicName: chapterArabicName),
          ElevatedButton(
              onPressed: () {
                controller.toggleChapterInfoVisibility();
              },
              child: const Text('chapter infromation')),
          const ChapterInfo(),
          const TranslationSettings(),
          const RecitersSettings(),
          ChapterVerses(chapterId: chapterId)
        ],
      ),
    );
  }
}

class ChapterInfo extends StatelessWidget {
  const ChapterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Obx(() {
      return Visibility(
          visible: controller.model.value.showChapterInfo,
          child: controller.model.value.chapterInfo.isEmpty
              ? const CircularProgressIndicator()
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(color: Colors.black)),
                  child: Text(controller.model.value.chapterInfo)));
    });
  }
}

class TranslationSettings extends StatelessWidget {
  const TranslationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return PopupMenuButton(
        icon: const Icon(Icons.school),
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

class ChapterVerses extends StatelessWidget {
  const ChapterVerses({required this.chapterId, super.key});
  final int chapterId;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Column(
          children: [
            Obx(() {
              return Expanded(
                child: ListView.builder(
                    itemCount: controller.model.value.chapterVerses.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: controller.getAyahColor(index + 1),
                            border: Border.all(color: Colors.black)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('${index + 1}'),
                                Expanded(
                                  child: Text(
                                      controller
                                          .model.value.chapterVerses[index],
                                      textDirection: TextDirection.rtl),
                                ),
                                Column(
                                  children: [
                                    VerseAudioControllers(
                                        chapterId: chapterId,
                                        ayahNumber: index + 1),
                                    Visibility(
                                        visible: controller
                                                .model.value.translationId !=
                                            0,
                                        child: IconButton(
                                            onPressed: () {
                                              controller.toggleTranslationState(
                                                  index + 1);
                                              controller
                                                  .getSpecifcAyahTranslation(
                                                      chapterId, index + 1);
                                            },
                                            icon: const Icon(Icons.school)))
                                  ],
                                )
                              ],
                            ),
                            TranslationBock(
                                chapterId: chapterId, ayahId: index + 1),
                          ],
                        ),
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class TranslationBock extends StatelessWidget {
  const TranslationBock(
      {required this.ayahId, required this.chapterId, super.key});

  final int ayahId;
  final int chapterId;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    if (controller.model.value.ayahTranslating == ayahId) {
      if (controller.model.value.ayahTranslationText.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Container(
          color: controller.getAyahColor(ayahId),
          child: Text(controller.model.value.ayahTranslationText),
        );
      }
    } else {
      return Container();
    }
  }
}

class VerseAudioControllers extends StatelessWidget {
  const VerseAudioControllers(
      {required this.ayahNumber, required this.chapterId, super.key});

  final int ayahNumber;
  final int chapterId;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    if (controller.model.value.chapterPlaying != chapterId) {
      if (controller.model.value.ayahPlaying == ayahNumber) {
        return Row(
          children: [
            VersePauseResume(ayahNumber),
            IconButton(
                onPressed: () {
                  controller.stop();
                },
                icon: const Icon(Icons.stop)),
          ],
        );
      } else {
        return IconButton(
            onPressed: () {
              //  controller.playAyah(ayahNumber);
            },
            icon: const Icon(Icons.play_arrow));
      }
    } else {
      return Container();
    }
  }
}

class VersePauseResume extends StatelessWidget {
  const VersePauseResume(this.ayahNumber, {super.key});
  final int ayahNumber;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    if (controller.model.value.ayahPaused == ayahNumber) {
      return IconButton(
          onPressed: () {
            controller.resume();
          },
          icon: const Icon(Icons.play_circle));
    } else {
      return IconButton(
          onPressed: () {
            controller.pause(ayahNumber);
          },
          icon: const Icon(Icons.pause));
    }
  }
}

class RecitersSettings extends StatelessWidget {
  const RecitersSettings({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalController gController = Get.find<GlobalController>();
    QuranController quranController = Get.find<QuranController>();
    return PopupMenuButton(
        icon: const Icon(Icons.account_circle),
        itemBuilder: (BuildContext context) {
          List<PopupMenuEntry<dynamic>> x =
              List.generate(Reciters.reciters.length, (index) {
            return PopupMenuItem(
              child: Text(Reciters.reciters[index].name),
              onTap: () async {
                await gController.updateReciter(Reciters.reciters[index].id,
                    quranController.stop, quranController.clearAudios);
              },
            );
          });
          return x;
        });
  }
}
