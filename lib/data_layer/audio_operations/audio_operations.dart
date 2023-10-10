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
