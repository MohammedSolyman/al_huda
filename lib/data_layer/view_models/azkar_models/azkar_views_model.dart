import 'package:al_huda/data_layer/json_models/azkar_model.dart';

class AzkarViewsModel {
  //this model is responsible for azkar home view and azkar category view

  //1. language data
  List<Category> languageAzkarCats = []; //all language categories
  List<Azkar> languageAzkar = []; //all language azkar
  List<Azkar> languageCategoryAzkar = []; //azkar of selected category
  String languageSelectedCategory = ''; //selected language category

  //2. arabic data
  List<Category> arabicAzkarCats = []; //all arabic categories
  List<Azkar> arabicAzkar = []; //all arabic azkar
  List<Azkar> arabicCategoryAzkar = []; //azkar of selected category
  String arabicSelectedCategory = ''; //selected arabic category
}
