class IndopakGuzChapterModel {
  List<Verse>? verses;
  Meta? meta;

  IndopakGuzChapterModel({
    this.verses,
    this.meta,
  });

  factory IndopakGuzChapterModel.fromJson(Map<String, dynamic> json) =>
      IndopakGuzChapterModel(
        verses: json["verses"] == null
            ? []
            : List<Verse>.from(json["verses"]!.map((x) => Verse.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "verses": verses == null
            ? []
            : List<dynamic>.from(verses!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class Meta {
  Filters? filters;

  Meta({
    this.filters,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        filters:
            json["filters"] == null ? null : Filters.fromJson(json["filters"]),
      );

  Map<String, dynamic> toJson() => {
        "filters": filters?.toJson(),
      };
}

class Filters {
  String? juzNumber;
  String? chapterNumber;

  Filters({
    this.juzNumber,
    this.chapterNumber,
  });

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        juzNumber: json["juz_number"],
        chapterNumber: json["chapter_number"],
      );

  Map<String, dynamic> toJson() => {
        "juz_number": juzNumber,
        "chapter_number": chapterNumber,
      };
}

class Verse {
  int? id;
  String? verseKey;
  String? textIndopak;

  Verse({
    this.id,
    this.verseKey,
    this.textIndopak,
  });

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        id: json["id"],
        verseKey: json["verse_key"],
        textIndopak: json["text_indopak"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "verse_key": verseKey,
        "text_indopak": textIndopak,
      };
}
