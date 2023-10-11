import 'package:al_huda/util/constants/internationlization_const.dart';
import 'package:get/get.dart';

class MyTranlations extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    Map<String, Map<String, String>> x = {
      'ar': arabic,
      'en': english,
      'fr': french,
      'es': spanish,
    };

    return x;
  }
}

Map<String, String> arabic = {
  IntConstants.praying: 'الصلاة',
  IntConstants.holyQuran: 'القران الكريم',
  IntConstants.lessons: 'دروس',
  IntConstants.athkar: 'أذكار',
  IntConstants.sortByChapter: 'ترتيب بالسورة',
  IntConstants.sortByGuz: 'ترتيب بالجزء'
};

Map<String, String> spanish = {
  IntConstants.praying: 'el orador',
  IntConstants.holyQuran: 'El sagrado Corán',
  IntConstants.lessons: 'Tutoriales',
  IntConstants.athkar: 'Recuerdos',
  IntConstants.sortByChapter: 'ordenar por capítulo',
  IntConstants.sortByGuz: 'ordenar por parte'
};

Map<String, String> english = {
  IntConstants.praying: 'praying',
  IntConstants.holyQuran: 'holy quran',
  IntConstants.lessons: 'lessons',
  IntConstants.athkar: 'athkar',
  IntConstants.sortByChapter: 'sort by chapter',
  IntConstants.sortByGuz: 'sort by guz'
};

Map<String, String> french = {
  IntConstants.praying: 'la prière',
  IntConstants.holyQuran: 'Le Coran',
  IntConstants.lessons: 'Tutoriels',
  IntConstants.athkar: 'Prières',
  IntConstants.sortByChapter: 'trier par chapitre',
  IntConstants.sortByGuz: 'trier par partie'
};
