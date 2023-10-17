import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_models/chapters_model.dart';
import 'package:al_huda/data_layer/api_models/audios_reciter_model.dart';
import 'package:al_huda/data_layer/api_models/translation_model.dart';
import 'package:al_huda/data_layer/api_models/translation_resource_model.dart';
import 'package:al_huda/data_layer/api_models/indopak_model.dart';
import 'package:al_huda/util/constants/apis_url.dart';
import 'package:http/http.dart';
import 'dart:convert';

class QuranApiOperations {
  dynamic chaptersList(String langCode) async {
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

  dynamic getChapterIndopak(int id) async {
    String uri = QuranApiUrl.indopakChapterUrl(id);

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        IndopakModel x = IndopakModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic getGuzIndopak(int guzNumber) async {
    String uri = QuranApiUrl.indopakGuzUrl(guzNumber);

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        IndopakModel x = IndopakModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic traslationsResource() async {
    //get the available translations info.
    String uri = QuranApiUrl.avalaibleTranslations;

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        TranslationResourceModel x = TranslationResourceModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic traslationChapter(int translationId, int chapterId) async {
    String uri = QuranApiUrl.translationChapterUrl(translationId, chapterId);

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

  dynamic traslationGuz(int translationId, int guzNumber) async {
    String uri = QuranApiUrl.translationGuzUrl(translationId, guzNumber);

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

  dynamic audiosReciterChapter(int recitationId, int chapterId) async {
    String uri = QuranApiUrl.audiosReciterChapterUrl(recitationId, chapterId);

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        AudiosReciterModel x = AudiosReciterModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic audiosReciterGuz(int recitationId, int guzNumber) async {
    String uri = QuranApiUrl.audiosReciterGuzUrl(recitationId, guzNumber);

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        AudiosReciterModel x = AudiosReciterModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
