import 'package:al_huda/Presentation_layer/views/azkar_views/azkar_home/azkar_home_view.dart';
import 'package:al_huda/Presentation_layer/views/quran_views/quran_home_view/quran_home_view.dart';
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
  // 5. device dimensions
  // 6. navigation

  Rx<GlobalModel> model = GlobalModel().obs;
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  // 1. theming

  // 2. reciters
  Future<void> updateReciterId(int reciterId) async {
    //if reciterId is different that the current reciter:

    if (model.value.selectedReciter != reciterId) {
      model.update((val) {
        val!.selectedReciter = reciterId;
      });
    }
  }

  // 3. internationalization
  void updateMyLocale(String langCode) async {
    //update the app language due to user selection.
    model.update((val) {
      val!.languageCode = langCode;
    });
    Locale l = Locale(langCode);
    await Get.updateLocale(l);
  }

  // 4. audio operations
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

  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> resumeAudio() async {
    await audioPlayer.play();
  }

  // 5. device dimensions
  void updateDeviceDimensions(double height, double width) {
    model.update((val) {
      val!.deviceHeight = height;
      val.deviceWidth = width;
    });
  }

  // 6. navigation
  void goToAzkarHome() {
    Get.to(() => const AzkarHomeView());
  }

  goToQuranHome() {
    Get.to(() => const QuranHomeView());
  }
}
