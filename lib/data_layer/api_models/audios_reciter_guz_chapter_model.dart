// To parse this JSON data, do
//
//     final audiosReciterGuzChapterModel = audiosReciterGuzChapterModelFromJson(jsonString);

import 'dart:convert';

AudiosReciterGuzChapterModel audiosReciterGuzChapterModelFromJson(String str) =>
    AudiosReciterGuzChapterModel.fromJson(json.decode(str));

String audiosReciterGuzChapterModelToJson(AudiosReciterGuzChapterModel data) =>
    json.encode(data.toJson());

class AudiosReciterGuzChapterModel {
  List<AudioFile>? audioFiles;
  Meta? meta;

  AudiosReciterGuzChapterModel({
    this.audioFiles,
    this.meta,
  });

  factory AudiosReciterGuzChapterModel.fromJson(Map<String, dynamic> json) =>
      AudiosReciterGuzChapterModel(
        audioFiles: json["audio_files"] == null
            ? []
            : List<AudioFile>.from(
                json["audio_files"]!.map((x) => AudioFile.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "audio_files": audioFiles == null
            ? []
            : List<dynamic>.from(audioFiles!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class AudioFile {
  String? verseKey;
  String? url;

  AudioFile({
    this.verseKey,
    this.url,
  });

  factory AudioFile.fromJson(Map<String, dynamic> json) => AudioFile(
        verseKey: json["verse_key"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "verse_key": verseKey,
        "url": url,
      };
}

class Meta {
  String? reciterName;
  String? recitationStyle;
  Filters? filters;

  Meta({
    this.reciterName,
    this.recitationStyle,
    this.filters,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        reciterName: json["reciter_name"],
        recitationStyle: json["recitation_style"],
        filters:
            json["filters"] == null ? null : Filters.fromJson(json["filters"]),
      );

  Map<String, dynamic> toJson() => {
        "reciter_name": reciterName,
        "recitation_style": recitationStyle,
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
