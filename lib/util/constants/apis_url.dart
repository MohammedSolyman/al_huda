class QuranApiUrl {
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //Base url of Quran.com api.fields //////////////////////////////////////////
  //Base url
  static const String _baseUrl = 'https://api.quran.com/api/v4/';

  //Base for ayah audio
  static const String audiobaseUrl = 'https://verses.quran.com/';

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //Translations. //////////////////////////////////////////////////////////////

  //get list of all available translations (all languages), optional parameters:
  //    language
  static const String avalaibleTranslations =
      '${_baseUrl}resources/translations';

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

  static String translationChapterUrl(int translationId, int chapterId) {
    return '${_baseUrl}quran/translations/$translationId?chapter_number=$chapterId';
  }

  static String TranslationGuzChapterUrl(
      int translationId, int chapterId, int guzNumber) {
    return '${_baseUrl}quran/translations/$translationId?chapter_number=$chapterId&juz_number=$guzNumber';
  }
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //Quran information. /////////////////////////////////////////////////////////

  //get list of all guzs (including verses maping).
  static const String allGuzsUrl = '$_baseUrl/juzs';

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

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //Script. ///////////////////////////////////////////////////////////////////

  //Get Indopak Script of ayah, Optional parameters:
  //    chapter_number
  //    juz_number
  //    page_number
  //    hizb_number
  //    verse_key
  static String indopakChapterUrl(int chapterId) {
    return '${_baseUrl}quran/verses/indopak?chapter_number=$chapterId';
  }

  static String indopakGuzChapterUrl(int guzNumber, int chapterId) {
    return '${_baseUrl}quran/verses/indopak?juz_number=$guzNumber&chapter_number=$chapterId';
  }

///////////////////////////////////////////////////////////////////////////////
// Audios

  //Get audios of a chapter by a specific reciter, required parameters:
  //    recitation_id
  //    chapter_number
  static String audiosReciterChapterUrl(int recitationId, int chapterId) {
    return '${_baseUrl}recitations/$recitationId/by_chapter/$chapterId';
  }

  //Get audios of a guz chapter by a specific reciter, required parameters:
  //    recitation_id
  //    juz_number
  static String audiosReciterGuzChapterUrl(int recitationId, int guzNumber) {
    return '${_baseUrl}recitations/$recitationId/by_juz/$guzNumber';
  }
}
