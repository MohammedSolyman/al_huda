import 'dart:convert';
import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/data_layer/json_models/azkar_model.dart';
import 'package:al_huda/data_layer/view_models/azkar_models/azkar_home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AzkarHomeController extends GetxController {
  Rx<AzkarHomeModel> model = AzkarHomeModel().obs;
  GlobalController gController = Get.find<GlobalController>();

  Future<void> getLangAzkar(BuildContext context) async {
    //1. getting current language
    String currentLangCode = gController.model.value.languageCode;

    //2. getting json data
    String response = await DefaultAssetBundle.of(context)
        .loadString("assets/azkar/$currentLangCode.json");

    var result = jsonDecode(response);

    AzkarModel langdata = AzkarModel.fromJson(result);

    //3. updating data
    model.update((val) {
      val!.languageAzkarCats = langdata.categories!;
      val.languageAzkar = langdata.azkar!;
    });
  }

  Future<void> getArabicAzkar(BuildContext context) async {
    //1. getting json data
    String response =
        await DefaultAssetBundle.of(context).loadString("assets/azkar/ar.json");

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

  List<Azkar> getLangCatAzkar(int catId) {
    //1. getting selected language tabweeb
    String langTabweeb = '';
    for (Category c in model.value.languageAzkarCats) {
      if (c.categoryId == catId) {
        langTabweeb = c.category!;
      }
    }

    //2. getting language azkar of selected language tabweeb
    List<Azkar> lgCtAz = [];
    for (Azkar z in model.value.languageAzkar) {
      if (z.tabweeb == langTabweeb) {
        lgCtAz.add(z);
      }
    }

    return lgCtAz;
    // model.update((val) {
    //   val!.languageCategoryAzkar = lgCtAz;
    // });
  }

  List<Azkar> getArabCatAzkar(List<Azkar> lnAzkar) {
    //1. getting the correesponding arabic azkar of the selected id

    List<Azkar> arabCtAz = [];
    for (Azkar z in lnAzkar) {
      for (Azkar arabZ in model.value.arabicAzkar) {
        if (arabZ.zekarId == z.zekarId!) {
          arabCtAz.add(arabZ);
          break;
        }
      }
    }

    return arabCtAz;
    // //2. updating arabic azkar of the corresponding language azkar
    // model.update((val) {
    //   val!.arabicCategoryAzkar = arabCtAz;
    // });
  }
}
