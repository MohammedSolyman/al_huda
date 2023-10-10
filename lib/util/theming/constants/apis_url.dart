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

  //get list of chapters, optional parameter:
  //    language
  static const String chaptersListUrl = '${_baseUrl}chapters?language=en';

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //endpoint methods of Quran.com api. /////////////////////////////////////////

  //Get Ayah recitations audio for specific Ayah, required parameters:
  //    recitation_id
  //    ayah_key
  static String ayahAudioUrl(int recitationId, int ayahNumber) {
    return '${_baseUrl}recitations/$recitationId/by_ayah/$ayahNumber';
  }

  //Get Chapter Info in specific language. Default to English, required parameters;
  //    Chapter number ( 1-114 )
  // optional parameters:
  //    language
  static String chapterInfoUrl(int id) {
    return '${_baseUrl}chapters/$id/info?language=en';
  }

  //Get versves of specific chapter. Default to English, required parameter:
  //    chapter_number
  // optional parameters
  //    language
  //    words
  //    translations
  //    audio
  //    tafsirs
  //    word_fields
  //    translation_fields
  //    fields
  //    page
  //    per_page
  static String chapterVersesUrl(int chapterNumber) {
    return '${_baseUrl}verses/by_chapter/$chapterNumber';
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

  //Get audio of a chapter by a specific reciter
  //chapter_recitations/:id/:chapter_number
  //static const String chaperAudioUrl = 'chapter_recitations/';
}
