import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/views/quran_views/chapter_view/chapter_view.dart';
import 'package:al_huda/Presentation_layer/views/quran_views/guz_view/guz_view.dart';
import 'package:al_huda/data_layer/api_models/chapters_model.dart';
import 'package:al_huda/util/constants/quran_sort.dart';
import 'package:al_huda/data_layer/api_operations/quran_api_operations.dart';
import 'package:al_huda/data_layer/view_models/quran_models/quran_home_model.dart';
import 'package:get/get.dart';

class QuranHomeController extends GetxController {
  Rx<QuranHomeModel> model = QuranHomeModel().obs;
  QuranApiOperations quranApi = QuranApiOperations();
  GlobalController iController = Get.find<GlobalController>();

  void updateQuranSort(QuranSort s) {
    model.update((val) {
      val!.quranSortValue = s;
    });
  }

  Future<void> updateChaptersList() async {
    //call this function at the beginning of quran home view.
    List<Chapter> x =
        await quranApi.chaptersList(iController.model.value.languageCode);
    model.update((val) {
      val!.chaptersList = x;
    });
  }

  void goToChapter({required int chapterId}) {
    Get.to(ChapterView(chapterId: chapterId));
  }

  void goToGuz({required int guzNumber}) {
    Get.to(GuzView(guzNumber: guzNumber));
  }
}
