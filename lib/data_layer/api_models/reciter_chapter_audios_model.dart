class ReciterChapterAudiosModel {
  List<AudioFile>? audioFiles;
  Meta? meta;

  ReciterChapterAudiosModel({
    this.audioFiles,
    this.meta,
  });

  factory ReciterChapterAudiosModel.fromJson(Map<String, dynamic> json) =>
      ReciterChapterAudiosModel(
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
  dynamic recitationStyle;

  Meta({
    this.reciterName,
    this.recitationStyle,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        reciterName: json["reciter_name"],
        recitationStyle: json["recitation_style"],
      );

  Map<String, dynamic> toJson() => {
        "reciter_name": reciterName,
        "recitation_style": recitationStyle,
      };
}
