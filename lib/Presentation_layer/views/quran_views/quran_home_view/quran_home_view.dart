import 'package:al_huda/util/theming/constants/quran_sort.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuranHomeView extends StatefulWidget {
  const QuranHomeView({super.key});

  @override
  State<QuranHomeView> createState() => _QuranHomeViewState();
}

class _QuranHomeViewState extends State<QuranHomeView> {
  @override
  Widget build(BuildContext context) {
    QuranHomeController controller = Get.put(QuranHomeController());
    return Scaffold(
        body: Column(
      children: [
        Obx(() => Row(
              children: [
                const Text('sorted by surah:'),
                Radio<QuranSort>(
                    value: QuranSort.byChapter,
                    groupValue: controller.model.value.quranSortValue,
                    onChanged: (QuranSort? s) {
                      controller.updateQuranSort(s!);
                    }),
                const Text('sorted by guz:'),
                Radio<QuranSort>(
                    value: QuranSort.byGuz,
                    groupValue: controller.model.value.quranSortValue,
                    onChanged: (QuranSort? s) {
                      controller.updateQuranSort(s!);
                    }),
              ],
            )),
        const MyListView()
      ],
    ));
  }
}

class MyListView extends StatelessWidget {
  const MyListView({super.key});

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
                        controller.model.value.chaptersList[index].id);
                  },
                  child: ListTile(
                    title: Text(
                        controller.model.value.chaptersList[index].nameArabic),
                    subtitle: Text(
                        controller.model.value.chaptersList[index].nameSimple),
                  ),
                );
              }),
        );
      }
    });
  }
}
