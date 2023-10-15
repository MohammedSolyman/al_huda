import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/views/quran_views/chapter_view.dart';
import 'package:al_huda/Presentation_layer/views/quran_views/guz_view.dart';
import 'package:al_huda/data_layer/api_models/chapters_model.dart';
import 'package:al_huda/data_layer/api_models/guz_model.dart';
import 'package:al_huda/util/constants/quran_sort.dart';
import 'package:al_huda/data_layer/api_operations/quran_api_operations.dart';
import 'package:al_huda/data_layer/view_models/quran_home_model.dart';
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
    List<Chapter> x =
        await quranApi.chaptersList(iController.model.value.languageCode);
    model.update((val) {
      val!.chaptersList = x;
    });
  }

  void goToChapter({required int chapterId}) {
    Get.to(ChapterView(chapterId: chapterId));
  }

  // updateGuzsList() async {
  //   GuzModel guzModel = await quranApi.getAllGuzs();
  //   List<Juz> juzsList = guzModel.juzs!;

  //   List<GuzMapping> a = [];

  //   for (Juz juz in juzsList) {
  //     Map<String, String> m = juz.verseMapping!;

  //     m.forEach((key, value) {
  //       int chapterId = int.parse(key);
  //       int firstAyahNumber = int.parse(value.split('-')[0]);
  //       int lastAyahNumber = int.parse(value.split('-')[1]);

  //       GuzMapping g = GuzMapping(
  //           guzNumber: juz.juzNumber!,
  //           chapterId: chapterId,
  //           firstAyahNumber: firstAyahNumber,
  //           lastAyahNumber: lastAyahNumber);

  //       a.add(g);
  //     });
  //   }
  //   model.update((val) {
  //     val!.mappingInThisGuz = a;
  //   });
  // }

  // List<GuzMapping> getSpecificGuzMapping(int guzId) {
  //   List<GuzMapping> x = [];

  //   for (GuzMapping gm in model.value.mappingInThisGuz) {
  //     if (gm.guzNumber == guzId) {
  //       x.add(gm);
  //     }
  //   }
  //   return x;
  // }
}
