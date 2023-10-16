import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_models/chapters_model.dart';
import 'package:al_huda/data_layer/api_models/indopak_guz_chapter_model.dart';
import 'package:al_huda/data_layer/api_models/guz_model.dart';
import 'package:al_huda/data_layer/api_models/audios_reciter_chapter_model.dart';
import 'package:al_huda/data_layer/api_models/audios_reciter_guz_chapter_model.dart';
import 'package:al_huda/data_layer/api_models/translation_model.dart';
import 'package:al_huda/data_layer/api_models/translation_resource_model.dart';
import 'package:al_huda/data_layer/api_models/indopak_chapter_model.dart';
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

        IndopakChapterModel x = IndopakChapterModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic getGuzChapterIndopak(int guzNumber, int chapterId) async {
    String uri = QuranApiUrl.indopakGuzChapterUrl(guzNumber, chapterId);

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        IndopakGuzChapterModel x = IndopakGuzChapterModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic traslationsresource() async {
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

  dynamic traslationGuzChapter(
      int translationId, int chapterId, int guzNumber) async {
    String uri = QuranApiUrl.translationGuzChapterUrl(
        translationId, chapterId, guzNumber);

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

  dynamic getAllGuzs() async {
    String uri = QuranApiUrl.allGuzsUrl;

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        GuzModel x = GuzModel.fromJson(result);

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

        AudiosReciterChapterModel x =
            AudiosReciterChapterModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic audiosReciterGuzChapter(
      int recitationId, int chapterId, int guzNumber) async {
    String uri = QuranApiUrl.audiosReciterGuzChapterUrl(
        recitationId, chapterId, guzNumber);

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        AudiosReciterGuzChapterModel x =
            AudiosReciterGuzChapterModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
