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
              ? const ChaptersView()
              : const GuzsView()
        ],
      );
    }));
  }
}

class GuzsView extends StatelessWidget {
  const GuzsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ChaptersView extends StatelessWidget {
  const ChaptersView({super.key});

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
                        controller.model.value.chaptersList[index].id,
                        controller.model.value.chaptersList[index].nameArabic,
                        controller.model.value.chaptersList[index]
                            .translatedName.name);
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
