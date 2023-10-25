import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/my_animation_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_api_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_home_controller.dart';
import 'package:al_huda/data_layer/api_models/audios_reciter_model.dart';
import 'package:al_huda/data_layer/api_models/indopak_model.dart';
import 'package:al_huda/data_layer/api_models/translation_resource_model.dart'
    as res;
import 'package:al_huda/data_layer/view_models/quran_model.dart';
import 'package:al_huda/util/constants/audio_state.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
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
  MyAnimationController aController = Get.find<MyAnimationController>();

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Modifying texts from foot notes

  String _removeNu(String org) {
    String newString = '';
    List<String> numbers = List.generate(10, (index) => index.toString());
    for (var i = 0; i < org.length; i++) {
      if (numbers.contains(org[i])) {
      } else {
        newString = newString + org[i];
      }
    }
    return newString;
  }

  String _removeSG(String org) {
    String newString = '';
    if (org.contains('sg')) {
      newString = org.replaceAll('sg', '');
      return newString;
    }
    return org;
  }

  String _removeBrackets(String org) {
    String newString = '';
    bool take = true;
    for (var i = 0; i < org.length; i++) {
      if (org[i] == '<') {
        take = false;
      }

      if (take) {
        newString = newString + org[i];
      }

      if (org[i] == '>') {
        take = true;
      }
    }
    return newString;
  }

  String _modifyText(String org) {
    String x = _removeNu(org);
    String y = _removeSG(x);
    String z = _removeBrackets(y);
    return z;
  }

////////////////////////////////////////////////////////////////////////////////
//Head values///////////////////////////////////////////////////////////////////

  Future<void> createHeadValues({int? chapterId, int? guzNumber}) async {
    //if this function is called from chapter view, chapterId will be passed.
    //if this function is callef from guz view, guzNumber will be passed.

    if (chapterId != null) {
      //1. In case of chapter view

      //1.1 arabic name
      String arabicName = quranHomeController
          .model.value.chaptersList[chapterId - 1].nameArabic;

      //1.2 language name
      String languageName = quranHomeController
          .model.value.chaptersList[chapterId - 1].translatedName.name;

      //1.3 Audio paths
      List<String> audiosPaths =
          await quranApiController.getReciterChapterAudios(chapterId);

      //1.4 MyAyahs scripts
      List<MyAyah> scripts =
          await quranApiController.getChapterIndopak(chapterId);

      //1.5 MyAyahs translations
      List<String> rawTranslations = await quranApiController
          .getTranslationChapter(model.value.translationId, chapterId);
      List<String> translations = [];
      for (String s in rawTranslations) {
        String newString = _modifyText(s);
        translations.add(newString);
      }

      //1.6 keys list
      List<GlobalKey> keys = List.generate(scripts.length, (index) {
        GlobalKey key = GlobalKey();
        return key;
      });

      //1.6 creating headValues
      HeadValues headBasics = HeadValues(
          chapterId: chapterId,
          arabicName: arabicName,
          languageName: languageName,
          audiosPaths: audiosPaths,
          scripts: scripts,
          type: 'chapter',
          translations: translations,
          keys: keys);

      model.update((val) {
        val!.heads = [headBasics];
      });
    } else {
      //2. In case of guz view

      //2.1 fetching chapters id's of this guz.
      List<int> chapterIds = GuzsChaptersConstant.guzsChapters[guzNumber]!;

      //2.2 fetching audio paths of this guz.
      List<AudioFile> guzAudiosPaths =
          await quranApiController.getReciterGuzAudios(guzNumber!);

      //2.3 fetching scripts of this guz.
      List<Verse> guzVerses =
          await quranApiController.getGuzIndopack(guzNumber);

      //2.4 fetching raw translationss of this guz.
      List<String> rawGuzTranslations = await quranApiController
          .getTranslationGuz(model.value.translationId, guzNumber);

      //2.5 extracting guz chapter data
      List<HeadValues> myList = [];
      for (int chapterId in chapterIds) {
        //2.5.1 extracting arabic name
        String arabicName = quranHomeController
            .model.value.chaptersList[chapterId - 1].nameArabic;

        //2.5.2 extracting language name
        String languageName = quranHomeController
            .model.value.chaptersList[chapterId - 1].translatedName.name;

        //2.5.3 extracting guz chapter audio paths
        List<String> audiosPaths = [];
        for (AudioFile v in guzAudiosPaths) {
          int vChptNum = int.parse(v.verseKey!.split(':').first);
          if (vChptNum == chapterId) {
            audiosPaths.add('https://verses.quran.com/${v.url!}');
          }
        }

        //2.5.4 extracting guz chapter scripts and translations
        List<MyAyah> scripts = [];
        List<String> translations = [];
        for (var i = 0; i < guzVerses.length; i++) {
          int vChptNum = int.parse(guzVerses[i].verseKey!.split(':').first);
          int myAyahNum = int.parse(guzVerses[i].verseKey!.split(':')[1]);

          if (vChptNum == chapterId) {
            MyAyah myAyah = MyAyah(guzVerses[i].textIndopak!, myAyahNum);
            scripts.add(myAyah);
            String trs = _modifyText(rawGuzTranslations[i]);
            translations.add(trs);
          }
        }

        //1.6 keys list
        List<GlobalKey> keys = List.generate(scripts.length, (index) {
          GlobalKey key = GlobalKey();
          return key;
        });

        //2.5.5 creating heads values

        HeadValues headBasics = HeadValues(
            chapterId: chapterId,
            arabicName: arabicName,
            languageName: languageName,
            audiosPaths: audiosPaths,
            scripts: scripts,
            translations: translations,
            type: 'guz',
            keys: keys);

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
    //1. play the audios list and allocate the current playing head to this head.
    await globalController.playAudios(urls);
    model.update((val) {
      val!.headPlaying = headIndex;
    });

    //2. Listen to the player, when the playlist finishes remove this head index
    //from the current playing head and reverse animation.
    globalController.audioPlayer.playlistFinished.listen((bool event) {
      if (event == true) {
        updateHeadSystem(headIndex, AudioState.stopped);
        updateMyAyahSysytem(headIndex, AudioState.stopped);
        model.update((val) {
          val!.heads[headIndex].playingMyAyahIndex = -1;
          val.headPlaying = -1;
        });
        aController.reverseAnimation();
      }
    });
  }

  updateListMyAyahPlaying(int headIndex) {
    //call this function after play() in head block
    //update the current ayah playing.

    globalController.audioPlayer.current.listen((Playing? event) {
      if (model.value.heads[headIndex].headSystemState == AudioState.playing) {
        model.update((val) {
          val!.heads[headIndex].playingMyAyahIndex = event!.index;
        });
      }
    });
  }

  updateMyAyahPlaying(int headIndex, int index) {
    //call this function after play() in MyAyah block
    //update the current ayah playing.

    model.update((val) {
      val!.heads[headIndex].playingMyAyahIndex = index;
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
      val!.heads[headIndex].playingMyAyahIndex = -1;
    });
  }

  void updateMyAyahSysytem(int headIndex, AudioState audioState) {
    model.update((val) {
      val!.heads[headIndex].myAyahSystemState = audioState;
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
      //1. in case of chapter view:

      //1.1 extracting chapter Id
      int chapterId = model.value.heads[0].chapterId;

      //1.2 fetching raw translation
      List<String> rawTranslations = await quranApiController
          .getTranslationChapter(model.value.translationId, chapterId);

      //1.3 filtering raw translations from foot note characters
      List<String> translations = [];
      for (String t in rawTranslations) {
        String trs = _modifyText(t);
        translations.add(trs);
      }

      //1.4 updating current translations
      model.update((val) {
        val!.heads[0].translations = translations;
      });
    } else {
      //2. in case of guz view:

      //1.1 fetching raw translation
      List<String> rawGuzTranslations = await quranApiController
          .getTranslationGuz(model.value.translationId, guzNumber!);

      //1.2 filtering raw translation and updating old translationss
      int gTIndex = 0;
      for (var headIndex = 0;
          headIndex < model.value.heads.length;
          headIndex++) {
        List<String> x = [];

        for (var i = 0; i < model.value.heads[headIndex].scripts.length; i++) {
          String trs = _modifyText(rawGuzTranslations[gTIndex]);
          x.add(trs);
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

  TextStyle getTextStyle(int headIndex, int index) {
    if (index == model.value.heads[headIndex].playingMyAyahIndex &&
        headIndex == model.value.headPlaying) {
      return TextStyle(
        color: BlueColor.blueColor.shade900,
        fontSize: TextSizes.medium,
        shadows: [
          Shadow(
              color: BlueColor.blueColor.shade400,
              blurRadius: 0.2,
              offset: const Offset(0.5, 0.5))
        ],
      );
    } else {
      return TextStyle(
        color: BlueColor.blueColor.shade400,
        fontSize: TextSizes.medium,
      );
    }
  }

  void chapterInfoVisibility(int headIndex) async {
    String info = '';
    //1. if the chapter info is empty, get info.
    if (model.value.heads[headIndex].chapterInfo.isEmpty) {
      int chapterId = model.value.heads[headIndex].chapterId;
      String rawInfo = await quranApiController.getChapterInfo(chapterId);
      info = _modifyText(rawInfo);
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

  void relocateToCurrentAyah(int headIndex) {
    int currentIndex = model.value.heads[headIndex].playingMyAyahIndex;

    // move to current ayah
    GlobalKey key = model.value.heads[headIndex].keys[currentIndex];
    Scrollable.ensureVisible(key.currentContext!);
  }

  @override
  void onInit() {
    super.onInit();
    getTranslationResources();
  }
}
