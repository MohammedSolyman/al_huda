class AyahAudioModel {
  List<AudioFile>? audioFiles;
  Pagination? pagination;

  AyahAudioModel({
    this.audioFiles,
    this.pagination,
  });

  factory AyahAudioModel.fromJson(Map<String, dynamic> json) => AyahAudioModel(
        audioFiles: json["audio_files"] == null
            ? []
            : List<AudioFile>.from(
                json["audio_files"]!.map((x) => AudioFile.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "audio_files": audioFiles == null
            ? []
            : List<dynamic>.from(audioFiles!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
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
