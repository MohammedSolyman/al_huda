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
  // ture if a chapter is playing now, false otherwise.
  bool chapterPlaying = false;
}
