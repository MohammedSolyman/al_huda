import 'package:al_huda/data_layer/view_models/global_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class GlobalController extends GetxController {
  //this controller is a global controller throuhgout all the app , and it is
  // responsive for:
  // 1. theming
  // 2. reciters
  // 3. internationalization
  // 4. audio operations

  Rx<GlobalModel> model = GlobalModel().obs;
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  void updateMyLocale(String langCode) async {
    //update the app language due to user selection.
    model.update((val) {
      val!.languageCode = langCode;
    });
    Locale l = Locale(langCode);
    await Get.updateLocale(l);
  }

  Future<void> updateReciter(
      int reciterId, Function stopHead, Function clearAudiosPaths) async {
    //if reciterId is different that the current reciter:
    //1. stop any playing and
    //2. update the reciter due to user selection.
    //3. clear audiospaths list

    if (model.value.selectedReciter != reciterId) {
      stopHead();
      model.update((val) {
        val!.selectedReciter = reciterId;
      });
      clearAudiosPaths();
    }
  }

  Future<void> playAudios(List<String> urls) async {
    List<Audio> audioList = [];

    for (String url in urls) {
      Audio audio = Audio.network(url);
      audioList.add(audio);
    }
    Playlist playlist = Playlist(audios: audioList, startIndex: 0);

    try {
      await audioPlayer.open(playlist);
    } catch (e) {
      print(e.toString());
    }
    await audioPlayer.play();
  }

  int getCurrentAudioIndex() {
    int currentIndex = 0;
    audioPlayer.current.listen((Playing? event) {
      currentIndex = event!.index;
    });
    return currentIndex;
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> resumeAudio() async {
    await audioPlayer.play();
  }
}
