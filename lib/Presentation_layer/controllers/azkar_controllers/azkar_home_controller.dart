import 'dart:convert';
import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/data_layer/json_models/azkar_model.dart';
import 'package:al_huda/data_layer/view_models/azkar_models/azkar_views_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AzkarController extends GetxController {
  //this controller is responsible for azkar home view and azkar category view
  Rx<AzkarViewsModel> model = AzkarViewsModel().obs;
  GlobalController gController = Get.find<GlobalController>();

  Future<void> getLangAzkar() async {
    //1. getting current language
    String currentLangCode = gController.model.value.languageCode;

    //2. getting json data
    String response =
        await rootBundle.loadString("assets/azkar/$currentLangCode.json");

    var result = jsonDecode(response);

    AzkarModel langdata = AzkarModel.fromJson(result);

    //3. updating data
    model.update((val) {
      val!.languageAzkarCats = langdata.categories!;
      val.languageAzkar = langdata.azkar!;
    });
  }

  Future<void> getArabicAzkar() async {
    //1. getting json data
    String response = await rootBundle.loadString("assets/azkar/ar.json");

    var result = jsonDecode(response);

    AzkarModel arabicdata = AzkarModel.fromJson(result);

    //2. extracting corresponding arabic categories
    List<Category> araCats = [];
    for (var langCat in model.value.languageAzkarCats) {
      for (var araCat in arabicdata.categories!) {
        if (langCat.categoryId == araCat.categoryId) {
          araCats.add(araCat);
        }
      }
    }

    //3. extracting corresponding arabic azar
    List<Azkar> araAzk = [];
    for (var langAzk in model.value.languageAzkar) {
      for (var aA in arabicdata.azkar!) {
        if (langAzk.zekarId == aA.zekarId) {
          araAzk.add(aA);
        }
      }
    }

    //4. updating data
    model.update((val) {
      val!.arabicAzkarCats = araCats;
      val.arabicAzkar = araAzk;
    });
  }

  void getCatAzkar(int catId) {
    //1. getting selected language tabweeb
    String langTabweeb = '';
    for (Category c in model.value.languageAzkarCats) {
      if (c.categoryId == catId) {
        langTabweeb = c.category!;
        break;
      }
    }

    //2. getting language azkar of selected language tabweeb
    List<Azkar> lgCtAz = [];
    for (Azkar z in model.value.languageAzkar) {
      if (z.tabweeb == langTabweeb) {
        lgCtAz.add(z);
      }
    }

    //3. updating data
    model.update((val) {
      val!.languageCategoryAzkar = lgCtAz;
      val.languageSelectedCategory = langTabweeb;
    });

    ////////////////////////
    //1. getting selected arabic tabweeb
    String araibTabweeb = '';
    for (Category c in model.value.arabicAzkarCats) {
      if (c.categoryId == catId) {
        araibTabweeb = c.category!;
        break;
      }
    }

    //2. getting the correesponding arabic azkar of the selected id
    List<Azkar> arabCtAz = [];
    for (Azkar z in lgCtAz) {
      for (Azkar arabZ in model.value.arabicAzkar) {
        if (arabZ.zekarId == z.zekarId!) {
          arabCtAz.add(arabZ);
          break;
        }
      }
    }

    //3. updating arabic azkar of the corresponding language azkar
    model.update((val) {
      val!.arabicCategoryAzkar = arabCtAz;
      val.arabicSelectedCategory = araibTabweeb;
    });
  }

  @override
  void onInit() async {
    super.onInit();
    await getLangAzkar();
    await getArabicAzkar();
  }
}
