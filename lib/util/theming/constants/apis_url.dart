class QuranApiUrl {
  //url and endpoint of Quran.com api.

  //base url
  static const String baseUrl = 'https://api.quran.com/api/v4/';

  //get list of chapters
  static const String chaptersListUrl = 'chapters?language=en';

//Get Chapter Info in specific language. Default to English
  static const String chapterInfoUrl1 = 'chapters/';
  static const String chapterInfoUrl2 = '/info?language=en';
}
