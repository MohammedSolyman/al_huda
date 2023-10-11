class TranslationModel {
  List<Translation>? translations;

  TranslationModel({
    this.translations,
  });

  factory TranslationModel.fromJson(Map<String, dynamic> json) =>
      TranslationModel(
        translations: json["translations"] == null
            ? []
            : List<Translation>.from(
                json["translations"]!.map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "translations": translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class Translation {
  int? id;
  String? name;
  String? authorName;
  String? slug;
  String? languageName;
  TranslatedName? translatedName;

  Translation({
    this.id,
    this.name,
    this.authorName,
    this.slug,
    this.languageName,
    this.translatedName,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        name: json["name"],
        authorName: json["author_name"],
        slug: json["slug"],
        languageName: json["language_name"],
        translatedName: json["translated_name"] == null
            ? null
            : TranslatedName.fromJson(json["translated_name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "author_name": authorName,
        "slug": slug,
        "language_name": languageName,
        "translated_name": translatedName?.toJson(),
      };
}

class TranslatedName {
  String? name;
  String? languageName;

  TranslatedName({
    this.name,
    this.languageName,
  });

  factory TranslatedName.fromJson(Map<String, dynamic> json) => TranslatedName(
        name: json["name"],
        languageName: json["language_name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "language_name": languageName,
      };
}
