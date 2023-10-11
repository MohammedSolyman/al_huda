class SpecificTranslationModel {
  List<Translation>? translations;
  Meta? meta;

  SpecificTranslationModel({
    this.translations,
    this.meta,
  });

  factory SpecificTranslationModel.fromJson(Map<String, dynamic> json) =>
      SpecificTranslationModel(
        translations: json["translations"] == null
            ? []
            : List<Translation>.from(
                json["translations"]!.map((x) => Translation.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "translations": translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class Meta {
  String? translationName;
  String? authorName;

  Meta({
    this.translationName,
    this.authorName,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        translationName: json["translation_name"],
        authorName: json["author_name"],
      );

  Map<String, dynamic> toJson() => {
        "translation_name": translationName,
        "author_name": authorName,
      };
}

class Translation {
  int? resourceId;
  String? text;

  Translation({
    this.resourceId,
    this.text,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        resourceId: json["resource_id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "resource_id": resourceId,
        "text": text,
      };
}
