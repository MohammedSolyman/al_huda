class ChpterInfoModel {
  ChapterInfo chapterInfo;

  ChpterInfoModel({
    required this.chapterInfo,
  });

  factory ChpterInfoModel.fromJson(Map<String, dynamic> json) =>
      ChpterInfoModel(
        chapterInfo: ChapterInfo.fromJson(json["chapter_info"]),
      );

  Map<String, dynamic> toJson() => {
        "chapter_info": chapterInfo.toJson(),
      };
}

class ChapterInfo {
  int id;
  int chapterId;
  String languageName;
  String shortText;
  String source;
  String text;

  ChapterInfo({
    required this.id,
    required this.chapterId,
    required this.languageName,
    required this.shortText,
    required this.source,
    required this.text,
  });

  factory ChapterInfo.fromJson(Map<String, dynamic> json) => ChapterInfo(
        id: json["id"],
        chapterId: json["chapter_id"],
        languageName: json["language_name"],
        shortText: json["short_text"],
        source: json["source"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chapter_id": chapterId,
        "language_name": languageName,
        "short_text": shortText,
        "source": source,
        "text": text,
      };
}
