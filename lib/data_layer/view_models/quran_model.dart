import 'package:al_huda/data_layer/api_models/translation_resource_model.dart';
import 'package:al_huda/util/constants/audio_state.dart';

class QuranModel {
//this model is for both ChapterView and GuzView screens.

  List<HeadValues> heads = [];

  bool showChapterInfo = true;

  //List of all available translation of specific language.
  List<Translation> languageTranslations = [];
  //id of the selected translation code, if 0 then there is no selected
  //translation selected.
  int translationId = 131;
}

class HeadValues {
  String type;
  int chapterId;
  String chapterInfo = '';
  String arabicName;
  String languageName;
  bool showInfo = false;

  List<Ayah> scripts = [];
  List<String> audiosPaths = [];
  List<String> translations = [];

//audio controllers.
  AudioState headSystemState = AudioState.stopped;
  AudioState ayahSystemState = AudioState.stopped;
  int playingAyahIndex = -1; //if -1, so there is no ayah playing

  HeadValues(
      {required this.type,
      required this.chapterId,
      required this.arabicName,
      required this.languageName,
      required this.audiosPaths,
      required this.scripts,
      required this.translations});
}

class Ayah {
  String script;
  int number;
  Ayah(this.script, this.number);
}
