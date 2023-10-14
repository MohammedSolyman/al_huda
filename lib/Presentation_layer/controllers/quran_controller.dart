import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_models/reciter_chapter_audios_model.dart';
import 'package:al_huda/data_layer/api_models/specific_translation_model.dart';
import 'package:al_huda/data_layer/api_models/translation_model.dart' as tm;
import 'package:al_huda/data_layer/api_models/verses_indopak_model.dart';
import 'package:al_huda/data_layer/api_operations/quran_api_operations.dart';
import 'package:al_huda/data_layer/view_models/quran_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuranController extends GetxController {
  //this controller is for both ChapterView and GuzView screens.

  QuranApiOperations quranApi = QuranApiOperations();
  Rx<QuranModel> model = QuranModel().obs;
  GlobalController globalController = Get.find<GlobalController>();

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

  // Future<void> playAyah({
  //   required int chapterId,
  //   required int ayahNumber,
  // }) async {
  //   await _getReciterChapterAudios(chapterId);

  //   model.update((val) {
  //     val!.chapterPlaying = chapterId;
  //     val.ayahPlaying = ayahNumber;
  //   });

  //   List<String> chapterPathsUrls = model.value.chapterAudiosPaths;
  //   List<String> urls = [chapterPathsUrls[ayahNumber]];
  //   await globalController.playAudios(urls);
  // }

  // Future<void> stopAyah() async {
  //   await audioOperations.stopAudio();
  //   model.update((val) {
  //     val!.ayahPlaying = 0;
  //     val.ayahPaused = 0;
  //   });
  // }

  // Future<void> pauseAyah(int ayahNumber) async {
  //   await audioOperations.pauseAudio();
  //   model.update((val) {
  //     val!.ayahPaused = ayahNumber;
  //   });
  // }

  // Future<void> resumeAyah(int ayahNumber) async {
  //   await audioOperations.resumeAudio();
  //   model.update((val) {
  //     val!.ayahPaused = 0;
  //   });
  // }

  Color getAyahColor(int ahayNumber) {
    if (model.value.ayahPlaying == ahayNumber) {
      return Colors.green;
    } else {
      return ahayNumber % 2 == 0 ? Colors.grey.shade400 : Colors.grey.shade700;
    }
  }

////////////////////////////////////////////////////////////////////////////////
// chapter audio controllers ///////////////////////////////////////////////////

  Future<void> _getReciterChapterAudios(int chapterId) async {
    //there are two prexes before each audio url:
    //https://verses.quran.com/
    //      ex: verses.quran.com/AbdulBaset/Mujawwad/mp3/001001.mp3
    //https://download.quranicaudio.com/qdc/
    //      ex: https://download.quranicaudio.com/qdc/abdul_baset/mujawwad/1.mp3

    ReciterChapterAudiosModel x = await quranApi.getReciterChapterAudios(
        globalController.model.value.selectedReciter, chapterId);

    List<String> audiosPaths = [];

    for (AudioFile a in x.audioFiles!) {
      audiosPaths.add('https://verses.quran.com/${a.url!}');
    }

    model.update((val) {
      val!.chapterAudiosPaths = audiosPaths;
    });
  }

  void _updateCurrentAyah(int currentAyah) {
    model.update((val) {
      val!.ayahPlaying = currentAyah;
    });
  }

  void _onCompleteChapter() {
    model.update((val) {
      val!.chapterPlaying = 0;
    });
  }

  Future<void> play({
    required int chapterId,
    required int firstAyah,
    required int lastAyah,
  }) async {
    await _getReciterChapterAudios(chapterId);

    model.update((val) {
      val!.chapterPlaying = chapterId;
    });

    List<String> chapterPathsUrls = model.value.chapterAudiosPaths;
    List<String> urls = chapterPathsUrls.sublist(firstAyah - 1, lastAyah);
    await globalController.playAudios(urls);
  }

  Future<void> pause(int chapterId) async {
    await globalController.pauseAudio();
    model.update((val) {
      val!.chapterPaused = chapterId;
    });
  }

  Future<void> resume() async {
    await globalController.resumeAudio();
    model.update((val) {
      val!.chapterPaused = 0;
    });
  }

  Future<void> stop() async {
    await globalController.stopAudio();
    model.update((val) {
      val!.chapterPlaying = 0;
      val.chapterPaused = 0;
      val.ayahPlaying = 0;
      val.AudioSession = val.AudioSession + 1;
    });
  }

  void clearAudios() {
    model.update((val) {
      val!.chapterAudiosPaths = [];
    });
  }
////////////////////////////////////////////////////////////////////////////////
// translations ////////////////////////////////////////////////////////////////

  Future<void> getLanguageTranslations() async {
    //get the available translations for a specific langage.
    tm.TranslationModel x = await quranApi.getAvailaleTraslations();
    List<tm.Translation> y = x.translations!;
    String queryLanguage = 'english';

    if (globalController.model.value.languageCode == 'ar') {
      queryLanguage = 'arabic';
    } else if (globalController.model.value.languageCode == 'es') {
      queryLanguage = 'spanish';
    } else if (globalController.model.value.languageCode == 'fr') {
      queryLanguage = 'french';
    }

    for (tm.Translation t in y) {
      if (t.languageName == queryLanguage) {
        model.update((val) {
          val!.languageTranslations.add(t);
        });
      }
    }
  }

  void toggleTranslationState(int ayahId) {
    if (model.value.ayahTranslating == 0) {
      model.update((val) {
        val!.ayahTranslating = ayahId;
      });
    } else {
      model.update((val) {
        val!.ayahTranslating = 0;
        val.ayahTranslationText = '';
      });
    }
  }

  void updateTranslationId(int translationId) {
    model.update((val) {
      val!.translationId = translationId;
    });
  }

  Future<void> getSpecifcAyahTranslation(int chapterId, int ayahNumber) async {
    SpecificTranslationModel x = await quranApi.getspecificTraslation(
        model.value.translationId, chapterId, ayahNumber);
    model.update((val) {
      val!.ayahTranslationText = x.translations![0].text!;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getLanguageTranslations();
  }
}