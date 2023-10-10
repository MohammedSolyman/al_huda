import 'package:al_huda/data_layer/api_models/ayah_audio_model.dart';
import 'package:al_huda/data_layer/api_models/chapter_audios_model.dart';
import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_models/chapter_verses_model.dart';
import 'package:al_huda/data_layer/api_models/chapters_model.dart';
import 'package:al_huda/data_layer/api_models/verses_indopak_model.dart';
import 'package:al_huda/util/theming/constants/apis_url.dart';
import 'package:http/http.dart';
import 'dart:convert';

class QuranApiOperations {
  dynamic getChaptersList() async {
    String uri = QuranApiUrl.chaptersListUrl;
    Uri url = Uri.parse(uri);
    try {
      Response response = await get(url);
      if (response.statusCode == 200) {
        String body = response.body;
        Map<String, dynamic> result = jsonDecode(body);
        ChaptersListModel x = ChaptersListModel.fromJson(result);
        return x.chapters;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic getChapterInfo(int id) async {
    String uri = QuranApiUrl.chapterInfoUrl(id);

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);
        ChpterInfoModel x = ChpterInfoModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic getchapterVerses(int id) async {
    String uri = QuranApiUrl.chapterVersesUrl(id);

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        ChapterVersesModel x = ChapterVersesModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic getChapterIndopak(int id) async {
    String uri = QuranApiUrl.chapterIndopakUrl(id);

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        VersesIndopakModel x = VersesIndopakModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic getChapterAudiosPaths(int chapterId, int recitationId) async {
    String uri = QuranApiUrl.chapterAudiosUrl(recitationId, chapterId);

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        ChapterAudiosModel x = ChapterAudiosModel.fromJson(result);

        return x.audioFiles;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic getayahAudioPath(int chapterId, int ayahNumber, int reciterId) async {
    String ayahKey = '$chapterId:$ayahNumber';
    String uri = QuranApiUrl.ayahAudioUrl(reciterId, ayahKey);

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        AyahAudioModel x = AyahAudioModel.fromJson(result);
        String fullPath = '${QuranApiUrl.audiobaseUrl}${x.audioFiles![0].url}';

        return fullPath;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
