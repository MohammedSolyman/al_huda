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
  IntConstants.prophet: 'السنة النبوية',
  IntConstants.sortByChapter: 'ترتيب بالسورة',
  IntConstants.sortByGuz: 'ترتيب بالجزء',
  IntConstants.centers: 'مراكز اسلامية',
  IntConstants.fromAlHudaapplication: 'من تطبيق الهدى',
  IntConstants.surahName: 'اسم السورة',
  IntConstants.ayahNumber: 'رقم الاية',
  IntConstants.translation: 'الترجمة',
  IntConstants.chooseReciter: 'اختر قارئ',
  IntConstants.chooseTranslation: 'اختر ترجمة'
};

Map<String, String> spanish = {
  IntConstants.praying: 'el orador',
  IntConstants.holyQuran: 'El sagrado Corán',
  IntConstants.lessons: 'Tutoriales',
  IntConstants.athkar: 'Recuerdos',
  IntConstants.prophet: 'sunna',
  IntConstants.sortByChapter: 'ordenar por capítulo',
  IntConstants.sortByGuz: 'ordenar por parte',
  IntConstants.centers: 'centros islámicos',
  IntConstants.fromAlHudaapplication: 'Desde la aplicación AlHuda',
  IntConstants.surahName: 'Nombre del capítulo',
  IntConstants.ayahNumber: 'Número ayah',
  IntConstants.translation: 'Traducción',
  IntConstants.chooseReciter: 'Elige un recitador',
  IntConstants.chooseTranslation: 'elige una traducción'
};

Map<String, String> english = {
  IntConstants.praying: 'praying',
  IntConstants.holyQuran: 'holy quran',
  IntConstants.lessons: 'lessons',
  IntConstants.athkar: 'athkar',
  IntConstants.prophet: 'Sunnah',
  IntConstants.sortByChapter: 'sort by chapter',
  IntConstants.sortByGuz: 'sort by guz',
  IntConstants.centers: 'Islamic centers',
  IntConstants.fromAlHudaapplication: 'from Al Huda application',
  IntConstants.surahName: 'Chapter name',
  IntConstants.ayahNumber: 'Ayah number',
  IntConstants.translation: 'Translation',
  IntConstants.chooseReciter: 'choose a reciter',
  IntConstants.chooseTranslation: 'choose a translation'
};

Map<String, String> french = {
  IntConstants.praying: 'la prière',
  IntConstants.holyQuran: 'Le Coran',
  IntConstants.lessons: 'Tutoriels',
  IntConstants.athkar: 'Prières',
  IntConstants.prophet: 'Sunna',
  IntConstants.sortByChapter: 'trier par chapitre',
  IntConstants.sortByGuz: 'trier par partie',
  IntConstants.centers: 'centres islamiques',
  IntConstants.fromAlHudaapplication: "De l'application Al Huda",
  IntConstants.surahName: 'Nom du chapitre',
  IntConstants.ayahNumber: 'Numéro ayah',
  IntConstants.translation: 'Traduction',
  IntConstants.chooseReciter: "choisir un récitant",
  IntConstants.chooseTranslation: 'choisissez une traduction'
};
