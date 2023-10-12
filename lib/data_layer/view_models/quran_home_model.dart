import 'package:al_huda/data_layer/api_models/chapters_model.dart';
import 'package:al_huda/util/constants/quran_sort.dart';

class QuranHomeModel {
  QuranSort quranSortValue = QuranSort.byChapter;
  //list of all chapters
  List<Chapter> chaptersList = [];
  //list of chapter mapping in this guz.
  List<GuzMapping> mappingInThisGuz = [];
}

class GuzMapping {
  int guzNumber;
  int chapterId;
  int firstAyahNumber;
  int lastAyahNumber;
  GuzMapping(
      {required this.guzNumber,
      required this.chapterId,
      required this.firstAyahNumber,
      required this.lastAyahNumber});
}
