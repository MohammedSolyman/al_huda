import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_models/indopak_model.dart';
import 'package:al_huda/data_layer/api_operations/quran_api_operations.dart';
import 'package:al_huda/data_layer/audio_operations/audio_operations.dart';
import 'package:al_huda/data_layer/view_models/chapter_view_model.dart';
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
    IndopakModel x = await quranApi.getChapterIndopak(model.value.chapterId);
    List<Verse>? verses = x.verses;

    for (var verse in verses!) {
      String ayah = verse.textIndopak!;

      model.update((val) {
        val!.chapterVerses.add(ayah);
      });
    }
  }

  playChapter() async {
    String path = await quranApi.getChapterAudioPath(model.value.chapterId, 1);
    print(path);
    await audioOperations.playAudio(path);
  }

  playAyah(int ayahNumber) async {
    String path =
        await quranApi.getayahAudioPath(model.value.chapterId, ayahNumber, 1);
    print(path);
    await audioOperations.playAudio(path);
  }
}
