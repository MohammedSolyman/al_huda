import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_home_controller.dart';
import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_models/audios_reciter_model.dart';
import 'package:al_huda/data_layer/api_models/translation_model.dart';
import 'package:al_huda/data_layer/api_models/translation_resource_model.dart'
    as res;
import 'package:al_huda/data_layer/api_models/indopak_model.dart';
import 'package:al_huda/data_layer/api_operations/quran_api_operations.dart';
import 'package:al_huda/data_layer/view_models/quran_model.dart';

import 'package:get/get.dart';

class QuranApiController extends GetxController {
  QuranApiOperations quranApi = QuranApiOperations();
  Rx<QuranModel> model = QuranModel().obs;
  GlobalController globalController = Get.find<GlobalController>();
  QuranHomeController quranHomeController = Get.find<QuranHomeController>();

  Future<List<String>> getReciterChapterAudios(int chapterId) async {
    //there are two prexes before each audio url:
    //https://verses.quran.com/
    //      ex: verses.quran.com/AbdulBaset/Mujawwad/mp3/001001.mp3
    //https://download.quranicaudio.com/qdc/
    //      ex: https://download.quranicaudio.com/qdc/abdul_baset/mujawwad/1.mp3

    AudiosReciterModel x = await quranApi.audiosReciterChapter(
        globalController.model.value.selectedReciter, chapterId);

    List<String> audiosPaths = [];

    for (AudioFile a in x.audioFiles!) {
      audiosPaths.add('https://verses.quran.com/${a.url!}');
    }
    return audiosPaths;
  }

  Future<List<AudioFile>> getReciterGuzAudios(int guzNumber) async {
    //there are two prexes before each audio url:
    //https://verses.quran.com/
    //      ex: verses.quran.com/AbdulBaset/Mujawwad/mp3/001001.mp3
    //https://download.quranicaudio.com/qdc/
    //      ex: https://download.quranicaudio.com/qdc/abdul_baset/mujawwad/1.mp3

    AudiosReciterModel x = await quranApi.audiosReciterGuz(
        globalController.model.value.selectedReciter, guzNumber);

    return x.audioFiles!;
  }

  Future<String> getChapterInfo(int chapterId) async {
    ChpterInfoModel x = await quranApi.getChapterInfo(chapterId);
    String chapterInfo = x.chapterInfo.shortText;

    return chapterInfo;
  }

  Future<List<Verse>> getGuzIndopack(int guzNumber) async {
    IndopakModel x = await quranApi.getGuzIndopak(guzNumber);
    return x.verses!;
  }

  Future<List<Ayah>> getChapterIndopak(int chapterId) async {
    IndopakModel x = await quranApi.getChapterIndopak(chapterId);
    List<Verse>? verses = x.verses;
    List<Ayah> chapterVerses = [];

    for (var verse in verses!) {
      String script = verse.textIndopak!;
      int number = int.parse(verse.verseKey!.split(':')[1]);
      Ayah ayah = Ayah(script, number);

      chapterVerses.add(ayah);
    }

    return chapterVerses;
  }

  Future<List<String>> getTranslationChapter(int chapterId) async {
    int translationId = model.value.translationId == 0
        ? model.value.languageTranslations[0].id!
        : model.value.translationId;

    TranslationModel x =
        await quranApi.traslationChapter(translationId, chapterId);

    List<String> translationChapter = [];

    for (Translation translation in x.translations!) {
      translationChapter.add(translation.text!);
    }

    return translationChapter;
  }

  Future<List<String>> getTranslationGuz(int guzNumber) async {
    int translationId = model.value.translationId == 0
        ? model.value.languageTranslations[0].id!
        : model.value.translationId;

    TranslationModel x = await quranApi.traslationGuz(translationId, guzNumber);

    List<String> translationChapter = [];

    for (Translation translation in x.translations!) {
      translationChapter.add(translation.text!);
    }

    return translationChapter;
  }

  Future<void> getLanguageTranslations() async {
    //get the available translations for a specific langage.
    res.TranslationResourceModel x = await quranApi.traslationsResource();

    List<res.Translation> y = x.translations!;
    String queryLanguage = 'english';

    if (globalController.model.value.languageCode == 'ar') {
      queryLanguage = 'arabic';
    } else if (globalController.model.value.languageCode == 'es') {
      queryLanguage = 'spanish';
    } else if (globalController.model.value.languageCode == 'fr') {
      queryLanguage = 'french';
    }

    for (res.Translation translationResource in y) {
      if (translationResource.languageName == queryLanguage) {
        model.update((val) {
          val!.languageTranslations.add(translationResource);
        });
      }
    }
  }
}
