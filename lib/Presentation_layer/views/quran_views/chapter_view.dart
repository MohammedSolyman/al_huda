import 'package:al_huda/Presentation_layer/controllers/chapter_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChapterView extends StatelessWidget {
  final int id;

  const ChapterView({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    ChapterViewController controller = Get.put(ChapterViewController());
    controller.updateId(id);
    controller.getInfo();
    controller.getchapterVerses();
    controller.getChapterIndopack();
    return const Scaffold(
      body: Column(
        children: [
          Text('chapter infromation'),
          Info(),
          Text('all chapter'),
          AllChapter()
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    ChapterViewController controller = Get.find<ChapterViewController>();

    return Obx(() {
      if (controller.model.value.chapterInfo.isEmpty) {
        return const CircularProgressIndicator();
      } else {
        return Text(controller.model.value.chapterInfo);
      }
    });
  }
}

class AllChapter extends StatelessWidget {
  const AllChapter({super.key});

  @override
  Widget build(BuildContext context) {
    ChapterViewController controller = Get.find<ChapterViewController>();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  controller.playChapter();
                },
                child: const Text('listen chapter')),
            ElevatedButton(
                onPressed: () {}, child: const Text('translate chapter')),
            Obx(() {
              return Expanded(
                child: ListView.builder(
                    itemCount: controller.model.value.chapterVerses.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            color:
                                index % 2 == 0 ? Colors.yellow : Colors.green,
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(controller.model.value.chapterVerses[index],
                                textDirection: TextDirection.rtl),
                            Column(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      controller.playAyah(index + 1);
                                    },
                                    child: Text('play ayah')),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text('translate ahay'))
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
