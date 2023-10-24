import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/internationlization_const.dart';
import 'package:al_huda/util/constants/quran_sort.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuranHomeView extends StatelessWidget {
  const QuranHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    QuranHomeController controller = Get.put(QuranHomeController());

    controller.updateChaptersList();

    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorsConst.blueDark,
          body: Obx(() {
            return Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Selection(),
                controller.model.value.quranSortValue == QuranSort.byChapter
                    ? const ChaptersBlock()
                    : const GuzsBlock()
              ],
            );
          })),
    );
  }
}

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
            style: const TextStyle(color: ColorsConst.yWhiteColor),
          ),
          Radio<QuranSort>(
              fillColor: const MaterialStatePropertyAll(ColorsConst.blueLight),
              value: QuranSort.byChapter,
              groupValue: controller.model.value.quranSortValue,
              onChanged: (QuranSort? s) {
                controller.updateQuranSort(s!);
              }),
          Text(IntConstants.sortByGuz.tr,
              style: const TextStyle(color: ColorsConst.yWhiteColor)),
          Radio<QuranSort>(
              fillColor: const MaterialStatePropertyAll(ColorsConst.blueLight),
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

class ChaptersBlock extends StatelessWidget {
  const ChaptersBlock({super.key});

  @override
  Widget build(BuildContext context) {
    QuranHomeController controller = Get.find<QuranHomeController>();

    return Obx(() {
      if (controller.model.value.chaptersList.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 50),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
                color: ColorsConst.blueLight),
            child: ListView.builder(
                itemCount: 114,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        controller.goToChapter(
                          chapterId:
                              controller.model.value.chaptersList[index].id,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(7),
                        height: 70,
                        decoration: const BoxDecoration(
                            color: ColorsConst.yWhiteColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: ColorsConst.greyDark),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  color: ColorsConst.greyDark,
                                  height: 30,
                                  width: 3,
                                ),
                                Text(
                                    controller.model.value.chaptersList[index]
                                        .translatedName.name,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: ColorsConst.greyDark))
                              ],
                            ),
                            Text(
                                controller
                                    .model.value.chaptersList[index].nameArabic,
                                style: const TextStyle(
                                    fontSize: 15, color: ColorsConst.greyDark))
                          ],
                        ),
                      ));
                }),
          ),
        );
      }
    });
  }
}

class GuzsBlock extends StatelessWidget {
  const GuzsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    QuranHomeController controller = Get.find<QuranHomeController>();
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 50),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
            color: ColorsConst.blueLight),
        child: ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    controller.goToGuz(guzNumber: index + 1);
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 70,
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                          color: ColorsConst.yWhiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('guz ${index + 1}',
                              style: const TextStyle(
                                  fontSize: 20, color: ColorsConst.greyDark)),
                          Text('جزء ${index + 1}',
                              style: const TextStyle(
                                  fontSize: 20, color: ColorsConst.greyDark)),
                        ],
                      )));
            }),
      ),
    );
  }
}
