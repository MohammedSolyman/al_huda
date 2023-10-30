import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/internationlization_const.dart';
import 'package:al_huda/util/constants/quran_sort.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controllers/quran_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Selection extends StatelessWidget {
  const Selection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    QuranHomeController controller = Get.find<QuranHomeController>();

    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            IntConstants.sortByChapter.tr,
            style: TextStyle(
                fontSize: TextSizes.normal, color: SkyColor.skyColor.shade200),
          ),
          Radio<QuranSort>(
              fillColor: MaterialStatePropertyAll(SkyColor.skyColor.shade200),
              value: QuranSort.byChapter,
              groupValue: controller.model.value.quranSortValue,
              onChanged: (QuranSort? s) {
                controller.updateQuranSort(s!);
              }),
          Text(IntConstants.sortByGuz.tr,
              style: TextStyle(
                  fontSize: TextSizes.normal,
                  color: SkyColor.skyColor.shade200)),
          Radio<QuranSort>(
              fillColor: MaterialStatePropertyAll(SkyColor.skyColor.shade200),
              value: QuranSort.byGuz,
              groupValue: controller.model.value.quranSortValue,
              onChanged: (QuranSort? s) {
                controller.updateQuranSort(s!);
              }),
        ],
      );
    });
  }
}
