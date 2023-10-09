class QuranApiUrl {
  //url and endpoint of Quran.com api.

  //base url
  static const String baseUrl = 'https://api.quran.com/api/v4/';

  //get list of chapters
  static const String chaptersListUrl = 'chapters?language=en';

  //Get Chapter Info in specific language. Default to English
  //chapters/{chapter_id}/info
  static const String chapterInfoUrl1 = 'chapters/';
  static const String chapterInfoUrl2 = '/info?language=en';

  //Get verves of specific chapter. Default to English
  //verses/by_chapter/{chapter_number}
  static const String chapterVersesUrl = 'verses/by_chapter/';

  //Get Indopak Script of ayah
  //add parameter chapter_number or verse_key.
  static const String indopakUrl = 'quran/verses/indopak';
}
