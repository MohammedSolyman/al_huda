import 'package:al_huda/Presentation_layer/views/quran_views/chapter_view.dart';
import 'package:al_huda/data_layer/api_models/chapters_model.dart';
import 'package:al_huda/util/theming/constants/quran_sort.dart';
import 'package:al_huda/data_layer/api_operations/quran_api_operations.dart';
import 'package:al_huda/data_layer/view_models/quran_home_model.dart';
import 'package:get/get.dart';

class QuranHomeController extends GetxController {
  Rx<QuranHomeModel> model = QuranHomeModel().obs;
  QuranApiOperations quranApi = QuranApiOperations();

  void updateQuranSort(QuranSort s) {
    model.update((val) {
      val!.quranSortValue = s;
    });
  }

  Future<void> updateChaptersList() async {
    List<Chapter> x = await quranApi.getChaptersList();
    model.update((val) {
      val!.chaptersList = x;
    });
  }

  void goToChapter(id) {
    Get.to(ChapterView(id: id));
  }

  @override
  void onInit() {
    super.onInit();
    updateChaptersList();
  }
}
