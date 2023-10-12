class QuranApiUrl {
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  // base url of Quran.com api.fields //////////////////////////////////////////
  //base url
  static const String _baseUrl = 'https://api.quran.com/api/v4/';

  //base for ayah audio
  static const String audiobaseUrl = 'https://verses.quran.com/';

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //endpoint fields of Quran.com api. //////////////////////////////////////////

  //get list of all available translations (all languages), optional parameters:
  //    language
  static const String avalaibleTranslations =
      '${_baseUrl}resources/translations';

  //get list of all guzs (including verses maping).
  static const String allGuzsUrl = '$_baseUrl/juzs';

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //endpoint methods of Quran.com api. /////////////////////////////////////////

  //get list of chapters, optional parameter:
  //    language
  static String chaptersListUrl(String langCode) {
    return '${_baseUrl}chapters?language=$langCode';
  }

  //Get Chapter Info in specific language. Default to English, required parameters;
  //    Chapter number ( 1-114 )
  // optional parameters:
  //    language
  static String chapterInfoUrl(int id) {
    return '${_baseUrl}chapters/$id/info?language=en';
  }

  //Get Indopak Script of ayah, Optional parameters:
  //    chapter_number
  //    juz_number
  //    page_number
  //    hizb_number
  //    verse_key
  static String chapterIndopakUrl(int chapterId) {
    return '${_baseUrl}quran/verses/indopak?chapter_number=$chapterId';
  }

  // //Get audio of a chapter by a specific reciter, required parameters:
  // //    recitation_id
  // //    chapter_number
  // static String chapterAudiosUrl(int recitationId, int chapterId) {
  //   return '${_baseUrl}recitations/$recitationId/by_chapter/$chapterId';
  // }

  //get ayah translate, required parameter:
  //    translation_id
  // optional parameters:
  //    fields
  //    chapter_number
  //    juz_number
  //    page_number
  //    hizb_number
  //    rub_el_hizb_number
  //    verse_key
  static String ayahTranslationUrl(
      int translationId, int chapterId, int ayahNumber) {
    return '${_baseUrl}quran/translations/$translationId?verse_key=$chapterId:$ayahNumber';
  }

  //get reciter audios, required parameter:
  //    recitation_id
  // optional parameters:
  //    fields
  //    chapter_number
  //    juz_number
  //    page_number
  //    hizb_number
  //    rub_el_hizb_number
  //    verse_key
  static String reciterChapterAudiosUrl(int recitationId, int chapterId) {
    return '$_baseUrl/quran/recitations/$recitationId?chapter_number=$chapterId';
  }
}
