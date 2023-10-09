import 'package:al_huda/data_layer/api_models/ayah_audio_model.dart';
import 'package:al_huda/data_layer/api_models/chapter_audio_model.dart';
import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_models/chapter_verses_model.dart';
import 'package:al_huda/data_layer/api_models/chapters_model.dart';
import 'package:al_huda/data_layer/api_models/indopak_model.dart';
import 'package:al_huda/util/theming/constants/apis_url.dart';
import 'package:http/http.dart';
import 'dart:convert';

class QuranApiOperations {
  dynamic getChaptersList() async {
    String uri = QuranApiUrl.baseUrl + QuranApiUrl.chaptersListUrl;
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
    String uri = QuranApiUrl.baseUrl +
        QuranApiUrl.chapterInfoUrl1 +
        id.toString() +
        QuranApiUrl.chapterInfoUrl2;

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
    String uri =
        QuranApiUrl.baseUrl + QuranApiUrl.chapterVersesUrl + id.toString();

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        chapterVersesModel x = chapterVersesModel.fromJson(result);

        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic getChapterIndopak(int id) async {
    String uri =
        '${QuranApiUrl.baseUrl}${QuranApiUrl.indopakUrl}?chapter_number=$id';

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

  dynamic getChapterAudioPath(int chapterId, int reciterid) async {
    String uri =
        '${QuranApiUrl.baseUrl}${QuranApiUrl.chaperAudioUrl}$reciterid/$chapterId';

    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        ChapterAudioModel x = ChapterAudioModel.fromJson(result);

        return x.audioFile!.audioUrl;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic getayahAudioPath(int chapterId, int ayahNumber, int reciterid) async {
    String uri =
        '${QuranApiUrl.baseUrl}${QuranApiUrl.ayahAudioUrl}$reciterid/by_ayah/$chapterId:$ayahNumber';

    print('-----r-------r---------uri');
    print(uri);
    Uri url = Uri.parse(uri);

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        String body = response.body;

        Map<String, dynamic> result = jsonDecode(body);

        AyahAudioModel x = AyahAudioModel.fromJson(result);
        String fullPath = '${QuranApiUrl.audiobaseUrl}${x.audioFiles![0].url}';
        print("=======================");
        print(fullPath);
        return fullPath;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
