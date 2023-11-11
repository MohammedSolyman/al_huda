import 'package:al_huda/Presentation_layer/controllers/azkar_controllers/azkar_home_controller.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZekrCategoryTitle extends StatelessWidget {
  const ZekrCategoryTitle({super.key});

  @override
  Widget build(BuildContext context) {
    AzkarController controller = Get.put(AzkarController());

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: BlueColor.blueColor.shade900,
              width: 4,
            ),
            gradient: LinearGradient(colors: [
              SeaColor.seaColorAccents.shade100,
              SeaColor.seaColorAccents.shade200,
              SeaColor.seaColorAccents.shade400,
              SeaColor.seaColorAccents.shade700,
            ]),
            boxShadow: [
              BoxShadow(
                  color: BlueColor.blueColor.shade900,
                  blurRadius: 5,
                  offset: const Offset(1, 1))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                controller.model.value.arabicSelectedCategory,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: TextSizes.medium,
                    color: SkyColor.skyColor.shade200),
              ),
              Text(controller.model.value.languageSelectedCategory,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: TextSizes.medium,
                    color: SkyColor.skyColor.shade200,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
