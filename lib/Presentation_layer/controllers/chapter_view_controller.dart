import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_models/chapter_audios_model.dart' as a;
import 'package:al_huda/data_layer/api_models/verses_indopak_model.dart';
import 'package:al_huda/data_layer/api_operations/quran_api_operations.dart';
import 'package:al_huda/data_layer/audio_operations/audio_operations.dart';
import 'package:al_huda/data_layer/view_models/chapter_view_model.dart';
import 'package:al_huda/util/theming/constants/apis_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChapterViewController extends GetxController {
  QuranApiOperations quranApi = QuranApiOperations();
  AudioOperations audioOperations = AudioOperations();
  Rx<ChapterViewModel> model = ChapterViewModel().obs;

  Future<void> updateId(int id) async {
    //update chapter id
    model.update((val) {
      val!.chapterId = id;
    });
  }

  Future<void> getInfo() async {
    ChpterInfoModel x = await quranApi.getChapterInfo(model.value.chapterId);
    String s = x.chapterInfo.shortText;
    model.update((val) {
      val!.chapterInfo = s;
    });
  }

  Future<void> getchapterVerses() async {
    await quranApi.getchapterVerses(model.value.chapterId);
  }

  Future<void> getChapterIndopack() async {
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

  void toggleChapterInfoVisibility() {
    model.update((val) {
      val!.showChapterInfo = !val.showChapterInfo;
    });
  }

////////////////////////////////////////////////////////////////////////////////
// verse audio controllers /////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////////////////////////////
// chapter audio controllers ///////////////////////////////////////////////////

  Future<void> _getChapterAudios(int chapterId) async {
    List<a.AudioFile> x = await quranApi.getChapterAudiosPaths(chapterId, 1);

    model.update((val) {
      for (a.AudioFile audioFile in x) {
        val!.chapterAudiosPaths
            .add('${QuranApiUrl.audiobaseUrl}${audioFile.url!}');
      }
    });
  }

  void _updateCurrentAyah(int currentAyah) {
    model.update((val) {
      val!.ayahPlaying = currentAyah;
    });
  }

  void _onCompleteChapter() {
    model.update((val) {
      val!.chapterPlaying = false;
    });
  }

  Future<void> playChapter(int chapterId) async {
    await _getChapterAudios(chapterId);
    model.update((val) {
      val!.chapterPlaying = true;
    });

    await audioOperations.playAudios(
        model.value.chapterAudiosPaths, _updateCurrentAyah, _onCompleteChapter);
  }
}
