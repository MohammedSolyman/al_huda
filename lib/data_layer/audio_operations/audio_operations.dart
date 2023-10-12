import 'package:audioplayers/audioplayers.dart';

class AudioOperations {
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAudio(String url, Function myFunc) async {
    Source source = UrlSource(url);
    await audioPlayer.play(source);
    audioPlayer.onPlayerComplete.listen((event) {
      myFunc();
    });
  }

  Future<void> playAudios(
      {required List<String> urls,
      required int firstAyah,
      required int lastAyah,
      required Function updateCurrentAyah,
      required Function onCompleteAudios}) async {
    //playing first ayah
    Source source = UrlSource(urls[firstAyah - 1]);
    audioPlayer.play(source);
    updateCurrentAyah(firstAyah);
    //playing next ayahs
    int i = firstAyah;
    audioPlayer.onPlayerComplete.listen((_) {
      if (i < lastAyah) {
        source = UrlSource(urls[i]);
        audioPlayer.play(source);
        updateCurrentAyah(i + 1);

        i++;
      } else {
        onCompleteAudios();
      }
    });
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  Future<void> resumeAudio() async {
    await audioPlayer.resume();
  }
}
