import 'package:al_huda/Presentation_layer/controllers/chapter_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChapterView extends StatelessWidget {
  final int chapterId;
  final String chapterArabicName;
  final String chapterLanguageName;

  const ChapterView(
      {required this.chapterId,
      required this.chapterArabicName,
      required this.chapterLanguageName,
      super.key});

  @override
  Widget build(BuildContext context) {
    ChapterViewController controller = Get.put(ChapterViewController());
    controller.updateId(chapterId);
    controller.getInfo();
    controller.getchapterVerses();
    controller.getChapterIndopack();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          ChapterName(
              chapterId: chapterId,
              chapterLanguageName: chapterLanguageName,
              chapterArabicName: chapterArabicName),
          ElevatedButton(
              onPressed: () {
                controller.toggleChapterInfoVisibility();
              },
              child: const Text('chapter infromation')),
          const ChapterInfo(),
          const ChapterVerses()
        ],
      ),
    );
  }
}

class ChapterName extends StatelessWidget {
  const ChapterName({
    super.key,
    required this.chapterId,
    required this.chapterLanguageName,
    required this.chapterArabicName,
  });

  final String chapterLanguageName;
  final String chapterArabicName;
  final int chapterId;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            chapterLanguageName,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          Text(
            chapterArabicName,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          ChapterAudioControllers(chapterId: chapterId)
        ],
      ),
    );
  }
}

class ChapterAudioControllers extends StatelessWidget {
  const ChapterAudioControllers({required this.chapterId, super.key});

  final int chapterId;
  @override
  Widget build(BuildContext context) {
    ChapterViewController controller = Get.put(ChapterViewController());
    if (controller.model.value.chapterPlaying) {
      return Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.pause,
                color: Colors.lightGreen,
                size: 40,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.stop,
                color: Colors.lightGreen,
                size: 40,
              )),
        ],
      );
    } else {
      return IconButton(
          onPressed: () {
            controller.playChapter(chapterId);
          },
          icon: const Icon(
            Icons.play_arrow,
            color: Colors.lightGreen,
            size: 40,
          ));
    }
  }
}

class ChapterInfo extends StatelessWidget {
  const ChapterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    ChapterViewController controller = Get.find<ChapterViewController>();

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

class ChapterVerses extends StatelessWidget {
  const ChapterVerses({super.key});

  @override
  Widget build(BuildContext context) {
    ChapterViewController controller = Get.find<ChapterViewController>();

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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                  controller.model.value.chapterVerses[index],
                                  textDirection: TextDirection.rtl),
                            ),
                            Column(
                              children: [
                                AudioControllers(index + 1),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('translate'))
                              ],
                            )
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

class AudioControllers extends StatelessWidget {
  const AudioControllers(this.ayahNumber, {super.key});

  final int ayahNumber;

  @override
  Widget build(BuildContext context) {
    ChapterViewController controller = Get.find<ChapterViewController>();

    if (!controller.model.value.chapterPlaying) {
      if (controller.model.value.ayahPlaying == ayahNumber) {
        return Row(
          children: [
            PauseResume(ayahNumber),
            IconButton(
                onPressed: () {
                  controller.stopAyah();
                },
                icon: const Icon(Icons.stop)),
          ],
        );
      } else {
        return IconButton(
            onPressed: () {
              controller.playAyah(ayahNumber);
            },
            icon: const Icon(Icons.play_arrow));
      }
    } else {
      return Container();
    }
  }
}

class PauseResume extends StatelessWidget {
  const PauseResume(this.ayahNumber, {super.key});
  final int ayahNumber;

  @override
  Widget build(BuildContext context) {
    ChapterViewController controller = Get.find<ChapterViewController>();

    if (controller.model.value.ayahPaused == ayahNumber) {
      return IconButton(
          onPressed: () {
            controller.resumeAyah(ayahNumber);
          },
          icon: const Icon(Icons.play_arrow));
    } else {
      return IconButton(
          onPressed: () {
            controller.pauseAyah(ayahNumber);
          },
          icon: const Icon(Icons.pause));
    }
  }
}
