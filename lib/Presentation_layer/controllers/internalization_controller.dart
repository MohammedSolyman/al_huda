import 'package:al_huda/data_layer/view_models/Internationalization_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternationalizationController extends GetxController {
  Rx<InternationalizationModel> model = InternationalizationModel().obs;

  updateMyLocate(String langCode) async {
    model.update((val) {
      val!.languageCode = langCode;
    });
    Locale l = Locale(langCode);
    await Get.updateLocale(l);
  }
}
