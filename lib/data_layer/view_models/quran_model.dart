import 'package:al_huda/data_layer/api_models/translation_resource_model.dart';

class QuranModel {
//this model is for both ChapterView and GuzView screens.

  List<HeadValues> heads = [];

  bool showChapterInfo = true;

  //List of all available translation of specific language.
  List<Translation> languageTranslations = [];
  //id of the selected translation code, if 0 then there is no selected
  //translation selected.
  int translationId = 0;
  //id of the ayah translated now, if 0 then there is no translated ayah now.
  int ayahTranslating = 0;
  //script of ayah translation
  String ayahTranslationText = '';
  //the number of the current audio session, when the user click stop, this
  //audioSession increases by 1.
}

class HeadValues {
  //Each headvalues must have chapter id and chapter info arabic and langauge
  //names.
  int chapterId;
  String chapterInfo;
  String arabicName;
  String languageName;

  List<Ayah>? scripts = [];

  List<String>? audiosPaths = [];

  List<String>? translations = [];

//audio controllers.
  bool headSound = true; //head sound system or ayah sound system
  bool audioPaused = false;
  bool audioStopped = false;

//showing chapter info
  bool showInfo = false;
  HeadValues({
    required this.chapterId,
    required this.chapterInfo,
    required this.arabicName,
    required this.languageName,
    this.audiosPaths,
    this.scripts,
    this.translations,
  });
}

class Ayah {
  String script;
  int number;
  Ayah(this.script, this.number);
}
