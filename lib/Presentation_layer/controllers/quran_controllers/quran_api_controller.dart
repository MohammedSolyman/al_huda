import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controllers/quran_home_controller.dart';
import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_models/audios_reciter_model.dart';
import 'package:al_huda/data_layer/api_models/translation_model.dart';
import 'package:al_huda/data_layer/api_models/translation_resource_model.dart'
    as res;
import 'package:al_huda/data_layer/api_models/indopak_model.dart';
import 'package:al_huda/data_layer/api_operations/quran_api_operations.dart';
import 'package:al_huda/data_layer/view_models/quran_models/quran_model.dart';
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

    int reciterId = globalController.model.value.selectedReciter;
    String p1 = 'https://verses.quran.com/';
    String prefix = '';
    if (reciterId == 6 || reciterId == 11 || reciterId == 12) {
      prefix = 'https:';
    } else {
      prefix = p1;
    }

    AudiosReciterModel x = await quranApi.audiosReciterChapter(
        globalController.model.value.selectedReciter, chapterId);

    List<String> audiosPaths = [];

    for (AudioFile a in x.audioFiles!) {
      audiosPaths.add('$prefix${a.url!}');
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

  Future<List<MyAyah>> getChapterIndopak(int chapterId) async {
    IndopakModel x = await quranApi.getChapterIndopak(chapterId);
    List<Verse>? verses = x.verses;
    List<MyAyah> chapterVerses = [];

    for (var verse in verses!) {
      String script = verse.textIndopak!;
      int number = int.parse(verse.verseKey!.split(':')[1]);
      MyAyah myAyah = MyAyah(script, number);

      chapterVerses.add(myAyah);
    }

    return chapterVerses;
  }

  Future<List<String>> getTranslationChapter(
      int translationId, int chapterId) async {
    TranslationModel x =
        await quranApi.traslationChapter(translationId, chapterId);

    List<String> translationChapter = [];

    for (Translation translation in x.translations!) {
      translationChapter.add(translation.text!);
    }

    return translationChapter;
  }

  Future<List<String>> getTranslationGuz(
      int translationId, int guzNumber) async {
    TranslationModel x = await quranApi.traslationGuz(translationId, guzNumber);

    List<String> translationChapter = [];

    for (Translation translation in x.translations!) {
      translationChapter.add(translation.text!);
    }

    return translationChapter;
  }

  Future<List<res.Translation>> getLanguageTranslations() async {
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
    List<res.Translation> a = [];
    for (res.Translation translationResource in y) {
      if (translationResource.languageName == queryLanguage) {
        a.add(translationResource);
      }
    }
    return a;
  }
}
