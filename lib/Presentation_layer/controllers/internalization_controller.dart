import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternationalizationController extends GetxController {
  Rx<String> languageCode = 'en'.obs;

  updateMyLocate(String langCode) async {
    Locale l = Locale(langCode);
    await Get.updateLocale(l);
    languageCode.value = langCode;
  }
}
