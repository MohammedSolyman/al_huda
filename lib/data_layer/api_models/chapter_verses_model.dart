class chapterVersesModel {
  List<Verse>? verses;
  Pagination? pagination;

  chapterVersesModel({
    this.verses,
    this.pagination,
  });

  factory chapterVersesModel.fromJson(Map<String, dynamic> json) =>
      chapterVersesModel(
        verses: json["verses"] == null
            ? []
            : List<Verse>.from(json["verses"]!.map((x) => Verse.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "verses": verses == null
            ? []
            : List<dynamic>.from(verses!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class Pagination {
  int? perPage;
  int? currentPage;
  int? nextPage;
  int? totalPages;
  int? totalRecords;

  Pagination({
    this.perPage,
    this.currentPage,
    this.nextPage,
    this.totalPages,
    this.totalRecords,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        perPage: json["per_page"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        totalPages: json["total_pages"],
        totalRecords: json["total_records"],
      );

  Map<String, dynamic> toJson() => {
        "per_page": perPage,
        "current_page": currentPage,
        "next_page": nextPage,
        "total_pages": totalPages,
        "total_records": totalRecords,
      };
}

class Verse {
  int? id;
  int? verseNumber;
  int? pageNumber;
  String? verseKey;
  int? juzNumber;
  int? hizbNumber;
  int? rubNumber;
  dynamic sajdahType;
  dynamic sajdahNumber;
  List<Word>? words;
  List<TranslationElement>? translations;
  List<Tafsir>? tafsirs;

  Verse({
    this.id,
    this.verseNumber,
    this.pageNumber,
    this.verseKey,
    this.juzNumber,
    this.hizbNumber,
    this.rubNumber,
    this.sajdahType,
    this.sajdahNumber,
    this.words,
    this.translations,
    this.tafsirs,
  });

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        id: json["id"],
        verseNumber: json["verse_number"],
        pageNumber: json["page_number"],
        verseKey: json["verse_key"],
        juzNumber: json["juz_number"],
        hizbNumber: json["hizb_number"],
        rubNumber: json["rub_number"],
        sajdahType: json["sajdah_type"],
        sajdahNumber: json["sajdah_number"],
        words: json["words"] == null
            ? []
            : List<Word>.from(json["words"]!.map((x) => Word.fromJson(x))),
        translations: json["translations"] == null
            ? []
            : List<TranslationElement>.from(json["translations"]!
                .map((x) => TranslationElement.fromJson(x))),
        tafsirs: json["tafsirs"] == null
            ? []
            : List<Tafsir>.from(
                json["tafsirs"]!.map((x) => Tafsir.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "verse_number": verseNumber,
        "page_number": pageNumber,
        "verse_key": verseKey,
        "juz_number": juzNumber,
        "hizb_number": hizbNumber,
        "rub_number": rubNumber,
        "sajdah_type": sajdahType,
        "sajdah_number": sajdahNumber,
        "words": words == null
            ? []
            : List<dynamic>.from(words!.map((x) => x.toJson())),
        "translations": translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
        "tafsirs": tafsirs == null
            ? []
            : List<dynamic>.from(tafsirs!.map((x) => x.toJson())),
      };
}

class Tafsir {
  int? id;
  String? languageName;
  String? name;
  String? text;

  Tafsir({
    this.id,
    this.languageName,
    this.name,
    this.text,
  });

  factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
        id: json["id"],
        languageName: json["language_name"],
        name: json["name"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language_name": languageName,
        "name": name,
        "text": text,
      };
}

class TranslationElement {
  int? resourceId;
  String? text;

  TranslationElement({
    this.resourceId,
    this.text,
  });

  factory TranslationElement.fromJson(Map<String, dynamic> json) =>
      TranslationElement(
        resourceId: json["resource_id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "resource_id": resourceId,
        "text": text,
      };
}

class Word {
  int? id;
  int? position;
  String? audioUrl;
  String? charTypeName;
  int? lineNumber;
  int? pageNumber;
  String? codeV1;
  TransliterationClass? translation;
  TransliterationClass? transliteration;

  Word({
    this.id,
    this.position,
    this.audioUrl,
    this.charTypeName,
    this.lineNumber,
    this.pageNumber,
    this.codeV1,
    this.translation,
    this.transliteration,
  });

  factory Word.fromJson(Map<String, dynamic> json) => Word(
        id: json["id"],
        position: json["position"],
        audioUrl: json["audio_url"],
        charTypeName: json["char_type_name"],
        lineNumber: json["line_number"],
        pageNumber: json["page_number"],
        codeV1: json["code_v1"],
        translation: json["translation"] == null
            ? null
            : TransliterationClass.fromJson(json["translation"]),
        transliteration: json["transliteration"] == null
            ? null
            : TransliterationClass.fromJson(json["transliteration"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
        "audio_url": audioUrl,
        "char_type_name": charTypeName,
        "line_number": lineNumber,
        "page_number": pageNumber,
        "code_v1": codeV1,
        "translation": translation?.toJson(),
        "transliteration": transliteration?.toJson(),
      };
}

class TransliterationClass {
  String? text;
  String? languageName;

  TransliterationClass({
    this.text,
    this.languageName,
  });

  factory TransliterationClass.fromJson(Map<String, dynamic> json) =>
      TransliterationClass(
        text: json["text"],
        languageName: json["language_name"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "language_name": languageName,
      };
}
