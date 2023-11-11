import 'package:al_huda/Presentation_layer/controllers/azkar_controllers/azkar_home_controller.dart';
import 'package:al_huda/Presentation_layer/views/azkar_views/zekr_category/components/zekr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZekrBody extends StatelessWidget {
  const ZekrBody({super.key});

  @override
  Widget build(BuildContext context) {
    AzkarController controller = Get.put(AzkarController());

    return Expanded(
      child: Scrollbar(
        interactive: true,
        radius: const Radius.circular(20),
        thickness: 15,
        thumbVisibility: false,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
            child: Column(
              children: List.generate(
                  controller.model.value.languageCategoryAzkar.length, (index) {
                String arabicZekr = controller
                    .model.value.arabicCategoryAzkar[index].zekarText!;
                String languageZekr = controller
                    .model.value.languageCategoryAzkar[index].zekarText!;
                return Zekr(
                  arabicZekr: arabicZekr,
                  languageZekr: languageZekr,
                  zekrNumber: index + 1,
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
