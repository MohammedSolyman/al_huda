class VersesIndopakModel {
  List<Verse>? verses;

  VersesIndopakModel({
    this.verses,
  });

  factory VersesIndopakModel.fromJson(Map<String, dynamic> json) =>
      VersesIndopakModel(
        verses: json["verses"] == null
            ? []
            : List<Verse>.from(json["verses"]!.map((x) => Verse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "verses": verses == null
            ? []
            : List<dynamic>.from(verses!.map((x) => x.toJson())),
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
