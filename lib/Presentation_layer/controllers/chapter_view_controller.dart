import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_models/verses_indopak_model.dart';
import 'package:al_huda/data_layer/api_operations/quran_api_operations.dart';
import 'package:al_huda/data_layer/audio_operations/audio_operations.dart';
import 'package:al_huda/data_layer/view_models/chapter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChapterViewController extends GetxController {
  QuranApiOperations quranApi = QuranApiOperations();
  AudioOperations audioOperations = AudioOperations();
  Rx<ChapterViewModel> model = ChapterViewModel().obs;

  void updateId(int id) async {
    //update chapter id
    model.update((val) {
      val!.chapterId = id;
    });
  }

  dynamic getInfo() async {
    ChpterInfoModel x = await quranApi.getChapterInfo(model.value.chapterId);
    String s = x.chapterInfo.shortText;
    model.update((val) {
      val!.chapterInfo = s;
    });
  }

  getchapterVerses() async {
    await quranApi.getchapterVerses(model.value.chapterId);
  }

  getChapterIndopack() async {
    VersesIndopakModel x =
        await quranApi.getChapterIndopak(model.value.chapterId);
    List<Verse>? verses = x.verses;

    for (var verse in verses!) {
      String ayah = verse.textIndopak!;

      model.update((val) {
        val!.chapterVerses.add(ayah);
      });
    }
  }

  void toggleChapterVisibility() {
    model.update((val) {
      val!.showChapterInfo = !val.showChapterInfo;
    });
  }

  void noAyahPlaying() {
    model.update((val) {
      val!.ayahPlaying = 0;
    });
  }

  Future<void> playAyah(int ayahNumber) async {
    String path =
        await quranApi.getayahAudioPath(model.value.chapterId, ayahNumber, 1);
    await audioOperations.playAudio(path, noAyahPlaying);
    model.update((val) {
      val!.ayahPlaying = ayahNumber;
    });
  }

  Future<void> stopAyah() async {
    await audioOperations.stopAudio();
    model.update((val) {
      val!.ayahPlaying = 0;
    });
  }

  Future<void> pauseAyah(int ayahNumber) async {
    await audioOperations.pauseAudio();
    model.update((val) {
      val!.ayahPaused = ayahNumber;
    });
  }

  Future<void> resumeAyah(int ayahNumber) async {
    await audioOperations.resumeAudio();
    model.update((val) {
      val!.ayahPaused = 0;
    });
  }

  Color getAyahColor(int ahayNumber) {
    if (model.value.ayahPlaying == ahayNumber) {
      return Colors.green;
    } else {
      return ahayNumber % 2 == 0 ? Colors.grey.shade400 : Colors.grey.shade700;
    }
  }
}
