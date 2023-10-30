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
}
