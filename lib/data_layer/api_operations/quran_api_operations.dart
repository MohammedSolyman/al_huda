import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_models/chapters_model.dart';
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
}
