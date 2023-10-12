import 'package:al_huda/Presentation_layer/controllers/chapter_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Head extends StatelessWidget {
  //this includes arabic and language chapter's names.
  //under this head, the all ayahs of chapter will be listed (in case of chapter
  // view),or some of ayahs of this chapter will be listed (in case of juz view).
  //this includes also audio controllers which plays the ayahs under this head.

  final int chapterId;
  final String chapterArabicName;
  final String chapterLanguageName;
  final int firstAyah;
  final int lastAyah;

  const Head(
      {required this.chapterId,
      required this.chapterArabicName,
      required this.chapterLanguageName,
      required this.firstAyah,
      required this.lastAyah,
      super.key});

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
          HeadAudioControllers(
            chapterId: chapterId,
            firstAyah: firstAyah,
            lastAyah: lastAyah,
          )
        ],
      ),
    );
  }
}

class HeadAudioControllers extends StatelessWidget {
  const HeadAudioControllers(
      {required this.chapterId,
      required this.firstAyah,
      required this.lastAyah,
      super.key});

  final int chapterId;
  final int firstAyah;
  final int lastAyah;
  @override
  Widget build(BuildContext context) {
    ChapterViewController controller = Get.put(ChapterViewController());
    return Obx(() {
      if (controller.model.value.chapterPlaying == chapterId) {
        return Row(
          children: [
            ChapterPauseResume(chapterId: chapterId),
            IconButton(
                onPressed: () {
                  controller.stopChapter();
                },
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
              controller.playHead(
                  chapterId: chapterId,
                  firstAyah: firstAyah,
                  lastAyah: lastAyah);
            },
            icon: const Icon(
              Icons.play_arrow,
              color: Colors.lightGreen,
              size: 40,
            ));
      }
    });
  }
}

class ChapterPauseResume extends StatelessWidget {
  const ChapterPauseResume({required this.chapterId, super.key});
  final int chapterId;

  @override
  Widget build(BuildContext context) {
    ChapterViewController controller = Get.put(ChapterViewController());

    return Obx(() {
      if (controller.model.value.chapterPaused == chapterId) {
        return IconButton(
            onPressed: () {
              controller.resumeChapter();
            },
            icon: const Icon(
              Icons.play_circle,
              color: Colors.lightGreen,
              size: 40,
            ));
      } else {
        return IconButton(
            onPressed: () {
              controller.pauseChapter(chapterId);
            },
            icon: const Icon(
              Icons.pause,
              color: Colors.lightGreen,
              size: 40,
            ));
      }
    });
  }
}
