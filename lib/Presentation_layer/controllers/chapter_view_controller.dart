import 'package:al_huda/data_layer/api_models/chapter_info.dart';
import 'package:al_huda/data_layer/api_operations/quran_api_operations.dart';
import 'package:al_huda/data_layer/view_models/chapter_view_model.dart';
import 'package:get/get.dart';

class ChapterViewController extends GetxController {
  QuranApiOperations quranApi = QuranApiOperations();
  Rx<ChapterViewModel> model = ChapterViewModel().obs;

  void updateIdGetInfo(int id) async {
    //update chapter id
    model.update((val) {
      val!.chapterId = id;
    });

    //get chapter info (short text)
    await getInfo();
  }

  getInfo() async {
    ChpterInfoModel x = await quranApi.getChapterInfo(model.value.chapterId);
    String s = x.chapterInfo.shortText;
    model.update((val) {
      val!.chapterInfo = s;
    });
  }
}
