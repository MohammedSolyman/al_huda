import 'package:al_huda/data_layer/view_models/global_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  //this controller is a global controller throuhgout all the app , and it is
  // responsive for:
  // 1. theming
  // 2. reciters
  // 3. internationalization

  Rx<GlobalModel> model = GlobalModel().obs;

  void updateMyLocate(String langCode) async {
    //update the app language due to user selection.
    model.update((val) {
      val!.languageCode = langCode;
    });
    Locale l = Locale(langCode);
    await Get.updateLocale(l);
  }

  void updateReciter(int reciterId) {
    //update the reciter due to user selection.
    model.update((val) {
      val!.selectedReciter = reciterId;
    });
  }
}
