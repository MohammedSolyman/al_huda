class QuranApiUrl {
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //Base url of Quran.com api.fields //////////////////////////////////////////
  //Base url
  static const String _baseUrl = 'https://api.quran.com/api/v4/';

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //Translations. //////////////////////////////////////////////////////////////

  //get list of all available translations (all languages), optional parameters:
  //    language
  static const String avalaibleTranslations =
      '${_baseUrl}resources/translations';

  //get MyAyah translate, required parameter:
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

  static String translationGuzUrl(int translationId, int guzNumber) {
    return '${_baseUrl}quran/translations/$translationId?juz_number=$guzNumber';
  }
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //Quran information. /////////////////////////////////////////////////////////

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
    return '${_baseUrl}chapters/$id/info';
  }

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //Script. ////////////////////////////////////////////////////////////////////

  //Get Indopak Script of MyAyah, Optional parameters:
  //    chapter_number
  //    juz_number
  //    page_number
  //    hizb_number
  //    verse_key
  static String indopakChapterUrl(int chapterId) {
    return '${_baseUrl}quran/verses/indopak?chapter_number=$chapterId';
  }

  static String indopakGuzUrl(int guzNumber) {
    return '${_baseUrl}quran/verses/indopak?juz_number=$guzNumber';
  }
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  // Audios

  //Get audios of a chapter by a specific reciter, required parameters:
  //    recitation_id
  // optional parameters:
  //    chapter_number
  //    juz_number
  //    page_number
  //    hizb_number
  //    rub_el_hizb_number
  //    verse_key
  static String audiosReciterChapterUrl(int recitationId, int chapterId) {
    return '${_baseUrl}quran/recitations/$recitationId?chapter_number=$chapterId';
  }

  static String audiosReciterGuzUrl(int recitationId, int guzNumber) {
    return '${_baseUrl}quran/recitations/$recitationId?juz_number=$guzNumber';
  }
}
