class ChapterAudioModel {
  AudioFile? audioFile;

  ChapterAudioModel({
    this.audioFile,
  });

  factory ChapterAudioModel.fromJson(Map<String, dynamic> json) =>
      ChapterAudioModel(
        audioFile: json["audio_file"] == null
            ? null
            : AudioFile.fromJson(json["audio_file"]),
      );

  Map<String, dynamic> toJson() => {
        "audio_file": audioFile?.toJson(),
      };
}

class AudioFile {
  int? id;
  int? chapterId;
  double? fileSize;
  String? format;
  int? totalFiles;
  String? audioUrl;

  AudioFile({
    this.id,
    this.chapterId,
    this.fileSize,
    this.format,
    this.totalFiles,
    this.audioUrl,
  });

  factory AudioFile.fromJson(Map<String, dynamic> json) => AudioFile(
        id: json["id"],
        chapterId: json["chapter_id"],
        fileSize: json["file_size"],
        format: json["format"],
        totalFiles: json["total_files"],
        audioUrl: json["audio_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chapter_id": chapterId,
        "file_size": fileSize,
        "format": format,
        "total_files": totalFiles,
        "audio_url": audioUrl,
      };
}
