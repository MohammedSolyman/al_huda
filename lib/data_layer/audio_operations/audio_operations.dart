import 'package:audioplayers/audioplayers.dart';

class AudioOperations {
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAudio(String url) async {
    Source source = UrlSource(url);
    await audioPlayer.play(source);
    audioPlayer.onPlayerComplete.listen((event) {});
  }
}
