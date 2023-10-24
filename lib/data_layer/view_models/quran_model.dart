import 'package:al_huda/data_layer/api_models/translation_resource_model.dart';
import 'package:al_huda/util/constants/audio_state.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class QuranModel {
//this model is for both ChapterView and GuzView screens.

  List<HeadValues> heads = [];
  bool showChapterInfo = true;
  //List of all available translation of specific language.
  List<Translation> languageTranslations = [];
  //id of the selected translation code, if 0 then there is no selected
  //translation selected.
  int translationId = 131;
  //Index of current playing head, if -1 so there is now heads are playing
  int headPlaying = -1;
}

class HeadValues {
  String type;
  int chapterId;
  String chapterInfo = '';
  String arabicName;
  String languageName;
  bool showInfo = false;
  List<GlobalKey> keys;
//  List<ScreenshotController> screencontrollers;
  List<MyAyah> scripts = [];
  List<String> audiosPaths = [];
  List<String> translations;
  AudioState headSystemState = AudioState.stopped;
  AudioState myAyahSystemState = AudioState.stopped;
  int playingMyAyahIndex = -1; //if -1, so there is no MyAyah playing

  HeadValues({
    required this.type,
    required this.chapterId,
    required this.arabicName,
    required this.languageName,
    required this.audiosPaths,
    required this.scripts,
    required this.translations,
    required this.keys,
    //required this.screencontrollers
  });
}

class MyAyah {
  String script;
  int number;
  MyAyah(this.script, this.number);
}
