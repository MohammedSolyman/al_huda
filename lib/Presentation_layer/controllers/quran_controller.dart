import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_home_controller.dart';
import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_models/indopak_guz_chapter_model.dart'
    as zci;
import 'package:al_huda/data_layer/api_models/audios_reciter_chapter_model.dart';
import 'package:al_huda/data_layer/api_models/audios_reciter_guz_chapter_model.dart'
    as g;
import 'package:al_huda/data_layer/api_models/translation_model.dart';
import 'package:al_huda/data_layer/api_models/translation_resource_model.dart'
    as res;
import 'package:al_huda/data_layer/api_models/indopak_chapter_model.dart';
import 'package:al_huda/data_layer/api_operations/quran_api_operations.dart';
import 'package:al_huda/data_layer/view_models/quran_model.dart';
import 'package:get/get.dart';

class QuranController extends GetxController {
  //this controller is for both ChapterView and GuzView screens.

  QuranApiOperations quranApi = QuranApiOperations();
  Rx<QuranModel> model = QuranModel().obs;
  GlobalController globalController = Get.find<GlobalController>();
  QuranHomeController quranHomeController = Get.find<QuranHomeController>();

  Future<List<String>> _getReciterChapterAudios(int chapterId) async {
    //there are two prexes before each audio url:
    //https://verses.quran.com/
    //      ex: verses.quran.com/AbdulBaset/Mujawwad/mp3/001001.mp3
    //https://download.quranicaudio.com/qdc/
    //      ex: https://download.quranicaudio.com/qdc/abdul_baset/mujawwad/1.mp3

    AudiosReciterChapterModel x = await quranApi.getReciterChapterAudios(
        globalController.model.value.selectedReciter, chapterId);

    List<String> audiosPaths = [];

    for (AudioFile a in x.audioFiles!) {
      audiosPaths.add('https://verses.quran.com/${a.url!}');
    }
    return audiosPaths;
  }

  Future<List<String>> _getReciterGuzChapterAudios(
      int chapterId, int guzNumber) async {
    //there are two prexes before each audio url:
    //https://verses.quran.com/
    //      ex: verses.quran.com/AbdulBaset/Mujawwad/mp3/001001.mp3
    //https://download.quranicaudio.com/qdc/
    //      ex: https://download.quranicaudio.com/qdc/abdul_baset/mujawwad/1.mp3

    g.AudiosReciterGuzChapterModel x =
        await quranApi.getReciterGuzChapterAudios(
            globalController.model.value.selectedReciter, chapterId);

    List<String> audiosPaths = [];

    for (g.AudioFile a in x.audioFiles!) {
      audiosPaths.add('https://verses.quran.com/${a.url!}');
    }
    return audiosPaths;
  }

  Future<String> _getChapterInfo(int chapterId) async {
    ChpterInfoModel x = await quranApi.getChapterInfo(chapterId);
    String chapterInfo = x.chapterInfo.shortText;

    return chapterInfo;
  }

  Future<List<Ayah>> _getGuzChapterIndopack(
      int guzNumber, int chapterId) async {
    zci.IndopakGuzChapterModel x =
        await quranApi.getGuzChapterIndopak(guzNumber, chapterId);

    List<zci.Verse>? verses = x.verses;

    List<Ayah> guzChapterIndopack = [];
    for (var verse in verses!) {
      String script = verse.textIndopak!;
      int number = int.parse(verse.verseKey!.split(':')[1]);
      Ayah ayah = Ayah(script, number);

      guzChapterIndopack.add(ayah);
    }
    return guzChapterIndopack;
  }

  Future<List<Ayah>> _getChapterIndopak(int chapterId) async {
    IndopakChapterModel x = await quranApi.getChapterIndopak(chapterId);
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

  Future<List<String>> _getTranslationChapter(int chapterId) async {
    TranslationModel x =
        await quranApi.traslationChapter(model.value.translationId, chapterId);

    List<String> translationChapter = [];

    for (Translation translation in x.translations!) {
      translationChapter.add(translation.text!);
    }

    return translationChapter;
  }

  Future<List<String>> _getTranslationGuzCahpter(
      int chapterId, int guzNumber) async {
    TranslationModel x = await quranApi.traslationGuzChapter(
        model.value.translationId, chapterId, guzNumber);

    List<String> translationChapter = [];

    for (Translation translation in x.translations!) {
      translationChapter.add(translation.text!);
    }

    return translationChapter;
  }

  Future<void> createHeadValues(List<int> chapterIds, bool isChapter,
      {int? guzNumber}) async {
    if (isChapter) {
      int chapterId = chapterIds[0];
      String chapterInfo = await _getChapterInfo(chapterId);
      List<String> audiosPaths = await _getReciterChapterAudios(chapterId);
      List<Ayah> scripts = await _getChapterIndopak(chapterId);
      List<String> translations = await _getTranslationChapter(chapterId);
      String arabicName = quranHomeController
          .model.value.chaptersList[chapterId - 1].nameArabic;
      String languageName = quranHomeController
          .model.value.chaptersList[chapterId - 1].translatedName.name;
      HeadValues headBasics = HeadValues(
          chapterId: chapterId,
          chapterInfo: chapterInfo,
          arabicName: arabicName,
          languageName: languageName,
          audiosPaths: audiosPaths,
          scripts: scripts,
          translations: translations);

      model.update((val) {
        val!.heads = [headBasics];
      });
    } else {
      List<HeadValues> myList = [];

      for (int chapterId in chapterIds) {
        String chapterInfo = await _getChapterInfo(chapterId);
        List<String> audiosPaths =
            await _getReciterGuzChapterAudios(chapterId, guzNumber!);
        List<Ayah> scripts = await _getGuzChapterIndopack(chapterId, guzNumber);
        List<String> translations =
            await _getTranslationGuzCahpter(chapterId, guzNumber);
        String arabicName = quranHomeController
            .model.value.chaptersList[chapterId - 1].nameArabic;
        String languageName = quranHomeController.model.value
            .chaptersList[chapterId - 1].translatedName.languageName;
        HeadValues headBasics = HeadValues(
            chapterId: chapterId,
            chapterInfo: chapterInfo,
            arabicName: arabicName,
            languageName: languageName,
            audiosPaths: audiosPaths,
            scripts: scripts,
            translations: translations);

        myList.add(headBasics);
      }
      model.update((val) {
        val!.heads = myList;
      });
    }
  }

  void toggleChapterInfoVisibility(int headIndex) {
    model.update((val) {
      val!.heads[headIndex].showInfo = !val.heads[headIndex].showInfo;
    });
  }

////////////////////////////////////////////////////////////////////////////////
// verse audio controllers /////////////////////////////////////////////////////
  // void noAyahPlaying() {
  //   model.update((val) {
  //     val!.ayahPlaying = 0;
  //   });
  // }

  // Color getAyahColor(int ahayNumber) {
  //   if (model.value.ayahPlaying == ahayNumber) {
  //     return Colors.green;
  //   } else {
  //     return ahayNumber % 2 == 0 ? Colors.grey.shade400 : Colors.grey.shade700;
  //   }
  // }

////////////////////////////////////////////////////////////////////////////////
// chapter audio controllers ///////////////////////////////////////////////////

  // void _updateCurrentAyah(int currentAyah) {
  //   model.update((val) {
  //     val!.ayahPlaying = currentAyah;
  //   });
  // }

  // void _onCompleteChapter() {
  //   model.update((val) {
  //     val!.chapterPlaying = 0;
  //   });
  // }

  Future<void> play(
      {required List<String> urls, required int headIndex}) async {
    await globalController.playAudios(urls);
    bool x = true;
    if (urls.length == 1) {
      x = false;
    }
    model.update((val) {
      val!.heads[headIndex].headSound = x;
    });
  }

  Future<void> pause(int headIndex) async {
    await globalController.pauseAudio();
    model.update((val) {
      val!.heads[headIndex].audioPaused = true;
    });
  }

  Future<void> resume(int headIndex) async {
    await globalController.resumeAudio();
    model.update((val) {
      val!.heads[headIndex].audioPaused = false;
    });
  }

  Future<void> stop(int headIndex) async {
    await globalController.stopAudio();
    model.update((val) {
      val!.heads[headIndex].audioStopped = true;
    });
  }

  // void clearAudios() {
  //   model.update((val) {
  //     val!.chapterAudiosPaths = [];
  //   });
  // }
////////////////////////////////////////////////////////////////////////////////
// translations ////////////////////////////////////////////////////////////////

  Future<void> getLanguageTranslations() async {
    //get the available translations for a specific langage.
    res.TranslationResourceModel x = await quranApi.traslationsresource();

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

  @override
  void onInit() {
    super.onInit();
    getLanguageTranslations();
  }
}
