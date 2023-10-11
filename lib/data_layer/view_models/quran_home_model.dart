import 'package:al_huda/data_layer/api_models/chapters_model.dart';
import 'package:al_huda/util/constants/quran_sort.dart';

class QuranHomeModel {
  QuranSort quranSortValue = QuranSort.byChapter;
  List<Chapter> chaptersList = [];
  List<Chapter> guzsList = [];
}
