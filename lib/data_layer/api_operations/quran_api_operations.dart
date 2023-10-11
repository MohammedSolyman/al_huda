import 'package:al_huda/data_layer/api_models/ayah_audio_model.dart';
import 'package:al_huda/data_layer/api_models/chapter_audios_model.dart';
import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_models/chapter_verses_model.dart';
import 'package:al_huda/data_layer/api_models/chapters_model.dart';
import 'package:al_huda/data_layer/api_models/specific_translation_model.dart';
import 'package:al_huda/data_layer/api_models/translation_model.dart';
import 'package:al_huda/data_layer/api_models/verses_indopak_model.dart';
import 'package:al_huda/util/constants/apis_url.dart';
import 'package:http/http.dart';
import 'dart:convert';

class QuranApiOperations {
  dynamic getChaptersList(String langCode) async {
    String uri = QuranApiUrl.chaptersListUrl(langCode);
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

  dynamic getAvailaleTraslations() async {
    //get the available translations info.
    String uri = QuranApiUrl.avalaibleTranslations;

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        TranslationModel x = TranslationModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic getspecificTraslation(
      int translationId, int chapterId, int ayahNumber) async {
    //get specif translation of a specific ayah.
    String uri =
        QuranApiUrl.ayahTranslationUrl(translationId, chapterId, ayahNumber);

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        SpecificTranslationModel x = SpecificTranslationModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
