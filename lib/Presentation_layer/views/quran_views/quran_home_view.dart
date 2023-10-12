import 'package:al_huda/data_layer/view_models/quran_home_model.dart';
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

    return Scaffold(body: Obx(() {
      return Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(IntConstants.sortByChapter.tr),
              Radio<QuranSort>(
                  value: QuranSort.byChapter,
                  groupValue: controller.model.value.quranSortValue,
                  onChanged: (QuranSort? s) {
                    controller.updateQuranSort(s!);
                  }),
              Text(IntConstants.sortByGuz.tr),
              Radio<QuranSort>(
                  value: QuranSort.byGuz,
                  groupValue: controller.model.value.quranSortValue,
                  onChanged: (QuranSort? s) {
                    controller.updateQuranSort(s!);
                  }),
            ],
          ),
          controller.model.value.quranSortValue == QuranSort.byChapter
              ? const ChaptersBlock()
              : const GuzsBlock()
        ],
      );
    }));
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
          child: ListView.builder(
              itemCount: 114,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    controller.goToChapter(
                        chapterId:
                            controller.model.value.chaptersList[index].id,
                        versesCount: controller
                            .model.value.chaptersList[index].versesCount,
                        chapterArabicName: controller
                            .model.value.chaptersList[index].nameArabic,
                        chapterLanguageName: controller.model.value
                            .chaptersList[index].translatedName.name);
                  },
                  child: ListTile(
                    title: Text(
                        controller.model.value.chaptersList[index].nameArabic),
                    subtitle: Text(controller
                        .model.value.chaptersList[index].translatedName.name),
                  ),
                );
              }),
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
    controller.updateGuzsList();
    return Expanded(
      child: ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                List<GuzMapping> z =
                    controller.getSpecificGuzMapping(index + 1);
                controller.goToGuzView(z);
              },
              child: ListTile(
                title: Text('guz ${index + 1}'),
              ),
            );
          }),
    );
  }
}
