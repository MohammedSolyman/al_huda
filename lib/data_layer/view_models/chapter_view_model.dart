import 'package:al_huda/data_layer/api_models/translation_model.dart';

class ChapterViewModel {
  int chapterId = 0;
  String chapterInfo = '';
  List<String> chapterVerses = [];
  List<String> chapterAudiosPaths = [];

  bool showChapterInfo = true;
  //id of the ahay that is playing now, if 0 then there is no ahay is playing
  //now.
  int ayahPlaying = 0;
  //id of the ahay that is paused now, if 0 then there is no ahay is paused
  //now.
  int ayahPaused = 0;
  //id of the chapter that is playing now, if 0 then there is no chapter is
  //playing now.
  int chapterPlaying = 0;
  //id of the chapter that is paused now, if 0 then there is no chapter is
  //paused now.
  int chapterPaused = 0;
  //List of all available translation of specific language.
  List<Translation> languageTranslations = [];
  //id of the selected translation code, if 0 then there is no selected
  //translation selected.
  int translationId = 0;
  //id of the ayah translated now, if 0 then there is no translated ayah now.
  int ayahTranslating = 0;
}
