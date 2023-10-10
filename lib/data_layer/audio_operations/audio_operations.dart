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

  Future<void> playAudios(List<String> urls, Function updateCurrentAyah,
      Function onCompleteAudios) async {
    Source source = UrlSource(urls[0]);
    audioPlayer.play(source);
    updateCurrentAyah(1);
    int i = 1;
    audioPlayer.onPlayerComplete.listen((_) {
      if (i < urls.length) {
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
