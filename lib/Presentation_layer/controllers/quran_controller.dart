import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_api_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_home_controller.dart';
import 'package:al_huda/data_layer/api_models/audios_reciter_model.dart';
import 'package:al_huda/data_layer/api_models/indopak_model.dart';
import 'package:al_huda/data_layer/api_models/translation_resource_model.dart'
    as res;
import 'package:al_huda/data_layer/view_models/quran_model.dart';
import 'package:al_huda/util/constants/audio_state.dart';
import 'package:al_huda/util/constants/guzs_chapters.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuranController extends GetxController {
  //this controller is for both ChapterView and GuzView screens.

  Rx<QuranModel> model = QuranModel().obs;
  GlobalController globalController = Get.find<GlobalController>();
  QuranHomeController quranHomeController = Get.find<QuranHomeController>();
  QuranApiController quranApiController = Get.put(QuranApiController());

////////////////////////////////////////////////////////////////////////////////
//Head values///////////////////////////////////////////////////////////////////
  Future<void> createHeadValues({int? chapterId, int? guzNumber}) async {
    //if this function is called from chapter view, chapterId will be passed.
    //if this function is callef from guz view, guzNumber will be passed.

    if (chapterId != null) {
      List<String> audiosPaths =
          await quranApiController.getReciterChapterAudios(chapterId);
      List<Ayah> scripts =
          await quranApiController.getChapterIndopak(chapterId);
      List<String> translations = await quranApiController
          .getTranslationChapter(model.value.translationId, chapterId);
      String arabicName = quranHomeController
          .model.value.chaptersList[chapterId - 1].nameArabic;
      String languageName = quranHomeController
          .model.value.chaptersList[chapterId - 1].translatedName.name;
      HeadValues headBasics = HeadValues(
          chapterId: chapterId,
          //  chapterInfo: chapterInfo,
          arabicName: arabicName,
          languageName: languageName,
          audiosPaths: audiosPaths,
          scripts: scripts,
          type: 'chapter',
          translations: translations);

      model.update((val) {
        val!.heads = [headBasics];
      });
    } else {
      //fetching guzs data
      List<AudioFile> guzAudiosPaths =
          await quranApiController.getReciterGuzAudios(guzNumber!);
      List<Verse> guzVerses =
          await quranApiController.getGuzIndopack(guzNumber);
      List<String> guzTranslations = await quranApiController.getTranslationGuz(
          model.value.translationId, guzNumber);

      //fetching chapters data
      List<int> chapterIds = GuzsChaptersConstant.guzsChapters[guzNumber]!;

      //extracting guz chapter data
      List<HeadValues> myList = [];

      for (int chapterId in chapterIds) {
        //1. extracting guz chapter audio paths
        List<String> audiosPaths = [];

        for (AudioFile v in guzAudiosPaths) {
          int vChptNum = int.parse(v.verseKey!.split(':').first);
          if (vChptNum == chapterId) {
            audiosPaths.add('https://verses.quran.com/${v.url!}');
          }
        }
        //2. extracting guz chapter scripts and translations
        List<Ayah> scripts = [];
        List<String> translations = [];
        for (var i = 0; i < guzVerses.length; i++) {
          int vChptNum = int.parse(guzVerses[i].verseKey!.split(':').first);
          int ayahNum = int.parse(guzVerses[i].verseKey!.split(':')[1]);

          if (vChptNum == chapterId) {
            Ayah ayah = Ayah(guzVerses[i].textIndopak!, ayahNum);
            scripts.add(ayah);
            translations.add(guzTranslations[i]);
          }
        }

        String arabicName = quranHomeController
            .model.value.chaptersList[chapterId - 1].nameArabic;

        String languageName = quranHomeController
            .model.value.chaptersList[chapterId - 1].translatedName.name;

        HeadValues headBasics = HeadValues(
            chapterId: chapterId,
            arabicName: arabicName,
            languageName: languageName,
            audiosPaths: audiosPaths,
            scripts: scripts,
            translations: translations,
            type: 'guz');

        myList.add(headBasics);
      }
      model.update((val) {
        val!.heads = myList;
      });
    }
  }

////////////////////////////////////////////////////////////////////////////////
//Audio/////////////////////////////////////////////////////////////////////////

  Future<void> play(
      {required List<String> urls, required int headIndex}) async {
    await globalController.playAudios(urls);

    globalController.audioPlayer.playlistFinished.listen((bool event) {
      if (event == true) {
        updateHeadSystem(headIndex, AudioState.stopped);
        updateAyahSysytem(headIndex, AudioState.stopped);
        model.update((val) {
          val!.heads[headIndex].playingAyahIndex = -1;
        });
      }
    });
  }

  updateListAyahPlaying(int headIndex) {
    //call this function after play() in head block

    globalController.audioPlayer.current.listen((Playing? event) {
      model.update((val) {
        val!.heads[headIndex].playingAyahIndex = event!.index;
      });
    });
  }

  updateAyahPlaying(int headIndex, int index) {
    //call this function after play() in ayah block
    model.update((val) {
      val!.heads[headIndex].playingAyahIndex = index;
    });
  }

  Future<void> pause(int headIndex) async {
    await globalController.pauseAudio();
    model.update((val) {});
  }

  Future<void> resume(int headIndex) async {
    await globalController.resumeAudio();
    model.update((val) {});
  }

  Future<void> stop(int headIndex) async {
    await globalController.stopAudio();

    model.update((val) {
      val!.heads[headIndex].playingAyahIndex = -1;
    });
  }

  void updateAyahSysytem(int headIndex, AudioState audioState) {
    model.update((val) {
      val!.heads[headIndex].ayahSystemState = audioState;
    });
  }

  void updateHeadSystem(int headIndex, AudioState audioState) {
    model.update((val) {
      val!.heads[headIndex].headSystemState = audioState;
    });
  }

////////////////////////////////////////////////////////////////////////////////
//reciters /////////////////////////////////////////////////////////////////////

  updateReciter(int reciterId, {int? guzNumber}) async {
    //update reciter code:

    globalController.updateReciterId(reciterId);
    //stop audio
    await stop(0);

    for (var index = 0; index < model.value.heads.length; index++) {
      if (model.value.heads[index].type == 'chapter') {
        //update chapter audio paths
        int chapterId = model.value.heads[index].chapterId;
        List<String> audiosPaths =
            await quranApiController.getReciterChapterAudios(chapterId);
        model.update((val) {
          val!.heads[0].audiosPaths = audiosPaths;
        });
      } else {
        int chapterId = model.value.heads[index].chapterId;

        //update guz audio paths
        List<AudioFile> guzAudiosPaths =
            await quranApiController.getReciterGuzAudios(guzNumber!);

        //1. extracting guz chapter audio paths
        List<String> audiosPaths = [];
        for (AudioFile v in guzAudiosPaths) {
          int vChptNum = int.parse(v.verseKey!.split(':').first);
          if (vChptNum == chapterId) {
            audiosPaths.add('https://verses.quran.com/${v.url!}');
          }
        }

        model.update((val) {
          val!.heads[index].audiosPaths = audiosPaths;
        });
      }
    }
  }

////////////////////////////////////////////////////////////////////////////////
// translations ////////////////////////////////////////////////////////////////

  void updateTranslationId(int translationId) {
    model.update((val) {
      val!.translationId = translationId;
    });
  }

  void updateTranslation({int? guzNumber}) async {
    if (model.value.heads.length == 1) {
      int chapterId = model.value.heads[0].chapterId;
      List<String> translations = await quranApiController
          .getTranslationChapter(model.value.translationId, chapterId);
      model.update((val) {
        val!.heads[0].translations = translations;
      });
    } else {
      //update translations

      List<String> guzTranslations = await quranApiController.getTranslationGuz(
          model.value.translationId, guzNumber!);
      int gTIndex = 0;
      for (var headIndex = 0;
          headIndex < model.value.heads.length;
          headIndex++) {
        List<String> x = [];

        for (var i = 0; i < model.value.heads[headIndex].scripts.length; i++) {
          x.add(guzTranslations[gTIndex]);
          gTIndex++;
        }
        model.update((val) {
          val!.heads[headIndex].translations = x;
        });
      }
    }
  }

////////////////////////////////////////////////////////////////////////////////
// others////// ////////////////////////////////////////////////////////////////

  Color getColor(int headIndex, int index) {
    if (index == model.value.heads[headIndex].playingAyahIndex) {
      return Colors.green.shade300;
    } else {
      if (index % 2 == 0) {
        return Colors.brown.shade100;
      } else {
        return Colors.brown.shade300;
      }
    }
  }

  void toggleChapterInfoVisibility(int headIndex) async {
    String info = '';
    if (model.value.heads[headIndex].chapterInfo.isEmpty) {
      int chapterId = model.value.heads[headIndex].chapterId;
      info = await quranApiController.getChapterInfo(chapterId);
    }

    model.update((val) {
      val!.heads[headIndex].showInfo = !val.heads[headIndex].showInfo;
      val.heads[headIndex].chapterInfo = info;
    });
  }

  getTranslationResources() async {
    List<res.Translation> x =
        await quranApiController.getLanguageTranslations();
    model.update((val) {
      val!.languageTranslations = x;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getTranslationResources();
  }
}
